--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 升阶魔法-革命之力  (ID: 43476205)
-- Type: Spell / Continuous
-- ATK 0 | DEF 0
-- Setcode: 149
--
-- Effect Text:
-- ①：可以把发动回合的以下效果发动。
-- ●自己回合：以自己场上1只「急袭猛禽」超量怪兽为对象才能发动。阶级高1阶的1只「急袭猛禽」怪兽在作为对象的自己怪兽上面重叠当作超量召唤从额外卡组特殊召唤。
-- ●对方回合：以对方场上1只没有超量素材的超量怪兽为对象才能发动。得到那只超量怪兽的控制权。那之后，阶级高1阶的1只「急袭猛禽」怪兽在作为对象的怪兽上面重叠当作超量召唤从额外卡组特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--RUM－レヴォリューション・フォース
function c43476205.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetHintTiming(0,TIMING_END_PHASE)
	e1:SetTarget(c43476205.target)
	e1:SetOperation(c43476205.activate)
	c:RegisterEffect(e1)
end
function c43476205.filter1(c,e,tp)
	local rk=c:GetRank()
	return rk>0 and c:IsFaceup() and c:IsSetCard(0xba)
		and Duel.IsExistingMatchingCard(c43476205.filter3,tp,LOCATION_EXTRA,0,1,nil,e,tp,c,rk+1)
		and aux.MustMaterialCheck(c,tp,EFFECT_MUST_BE_XMATERIAL)
end
function c43476205.filter2(c,e,tp)
	local rk=c:GetRank()
	return rk>0 and c:IsFaceup() and c:GetOverlayCount()==0 and c:IsControlerCanBeChanged() and aux.MustMaterialCheck(c,1-tp,EFFECT_MUST_BE_XMATERIAL)
		and Duel.IsExistingMatchingCard(c43476205.filter3,tp,LOCATION_EXTRA,0,1,nil,e,tp,c,rk+1)
end
function c43476205.filter3(c,e,tp,mc,rk)
	return c:IsRank(rk) and c:IsSetCard(0xba) and mc:IsCanBeXyzMaterial(c)
		and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_XYZ,tp,false,false) and Duel.GetLocationCountFromEx(tp,tp,mc,c)>0
end
function c43476205.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if Duel.GetTurnPlayer()==tp then
		if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_MZONE) and c43476205.filter1(chkc,e,tp) end
		if chk==0 then return Duel.IsExistingTarget(c43476205.filter1,tp,LOCATION_MZONE,0,1,nil,e,tp) end
		e:SetCategory(CATEGORY_SPECIAL_SUMMON)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
		Duel.SelectTarget(tp,c43476205.filter1,tp,LOCATION_MZONE,0,1,1,nil,e,tp)
	else
		if chkc then return chkc:IsControler(1-tp) and chkc:IsLocation(LOCATION_MZONE) and c43476205.filter2(chkc,e,tp) end
		if chk==0 then return Duel.IsExistingTarget(c43476205.filter2,tp,0,LOCATION_MZONE,1,nil,e,tp) end
		e:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_CONTROL)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
		local g=Duel.SelectTarget(tp,c43476205.filter2,tp,0,LOCATION_MZONE,1,1,nil,e,tp)
		Duel.SetOperationInfo(0,CATEGORY_CONTROL,g,1,0,0)
	end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c43476205.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if Duel.GetTurnPlayer()~=tp then
		if not tc:IsRelateToEffect(e) or tc:IsFacedown() then return end
		if Duel.GetControl(tc,tp)==0 then return end
		Duel.BreakEffect()
	end
	if not aux.MustMaterialCheck(tc,tp,EFFECT_MUST_BE_XMATERIAL) then return end
	if tc:IsFacedown() or not tc:IsRelateToEffect(e) or tc:IsControler(1-tp) or tc:IsImmuneToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c43476205.filter3,tp,LOCATION_EXTRA,0,1,1,nil,e,tp,tc,tc:GetRank()+1)
	local sc=g:GetFirst()
	if sc then
		local mg=tc:GetOverlayGroup()
		if mg:GetCount()~=0 then
			Duel.Overlay(sc,mg)
		end
		sc:SetMaterial(Group.FromCards(tc))
		Duel.Overlay(sc,Group.FromCards(tc))
		Duel.SpecialSummon(sc,SUMMON_TYPE_XYZ,tp,tp,false,false,POS_FACEUP)
		sc:CompleteProcedure()
	end
end
