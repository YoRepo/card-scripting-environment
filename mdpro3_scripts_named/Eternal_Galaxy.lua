--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 永远的银河  (ID: 82162616)
-- Type: Trap
-- ATK 0 | DEF 0
-- Setcode: 123
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张。
-- ①：自己场上有「光子」怪兽或「银河」怪兽存在的场合，以自己场上1只超量怪兽为对象才能发动。比那只自己怪兽阶级高4阶的1只「光子」超量怪兽或「银河」超量怪兽在作为对象的怪兽上面重叠当作超量召唤从额外卡组
-- 特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--永遠なる銀河
function c82162616.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(82162616,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,82162616+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(c82162616.condition)
	e1:SetTarget(c82162616.target)
	e1:SetOperation(c82162616.activate)
	c:RegisterEffect(e1)
end
function c82162616.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x55,0x7b)
end
function c82162616.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c82162616.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c82162616.filter1(c,e,tp)
	local rk=c:GetRank()
	return c:IsFaceup() and c:IsType(TYPE_XYZ)
		and Duel.IsExistingMatchingCard(c82162616.filter2,tp,LOCATION_EXTRA,0,1,nil,e,tp,c,rk+4)
		and aux.MustMaterialCheck(c,tp,EFFECT_MUST_BE_XMATERIAL)
end
function c82162616.filter2(c,e,tp,mc,rk)
	return c:IsRank(rk) and c:IsSetCard(0x55,0x7b) and mc:IsCanBeXyzMaterial(c)
		and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_XYZ,tp,false,false) and Duel.GetLocationCountFromEx(tp,tp,mc,c)>0
end
function c82162616.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_MZONE) and c82162616.filter1(chkc,e,tp) end
	if chk==0 then return Duel.IsExistingTarget(c82162616.filter1,tp,LOCATION_MZONE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c82162616.filter1,tp,LOCATION_MZONE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c82162616.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if not aux.MustMaterialCheck(tc,tp,EFFECT_MUST_BE_XMATERIAL) then return end
	if tc:IsFacedown() or not tc:IsRelateToEffect(e) or tc:IsControler(1-tp) or tc:IsImmuneToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c82162616.filter2,tp,LOCATION_EXTRA,0,1,1,nil,e,tp,tc,tc:GetRank()+4)
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
