--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 升阶魔法-幻影骑士团的镇魂歌  (ID: 62104532)
-- Type: Spell
-- ATK 0 | DEF 0
-- Setcode: 9769179
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张。
-- ①：以自己的墓地·除外状态的1只「幻影骑士团」怪兽或「超量龙」怪兽为对象才能发动。那只怪兽效果无效特殊召唤。那之后，以下效果适用。
-- ●选自己场上1只暗属性超量怪兽，比那只怪兽阶级高1阶的1只「幻影骑士团」超量怪兽或「超量龙」超量怪兽在选的怪兽上面重叠当作超量召唤从额外卡组特殊召唤。
--[[ __CARD_HEADER_END__ ]]

--RUM－幻影騎士団レクイエム
local s,id,o=GetID()
function s.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1,id+EFFECT_COUNT_CODE_OATH)
	e1:SetTarget(s.target)
	e1:SetOperation(s.activate)
	c:RegisterEffect(e1)
end
function s.cfilter(c,tp)
	return c:IsFaceup() and c:IsType(TYPE_XYZ) and c:IsAttribute(ATTRIBUTE_DARK)
		and aux.MustMaterialCheck(c,tp,EFFECT_MUST_BE_XMATERIAL)
end
function s.spfilter(c,e,tp,g)
	local sg=g:Clone()
	sg:AddCard(c)
	return c:IsFaceupEx() and c:IsSetCard(0x10db,0x2073)
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
		and sg:IsExists(s.stfilter,1,nil,e,tp)
end
function s.stfilter(c,e,tp)
	return c:IsFaceupEx() and c:IsType(TYPE_XYZ) and c:IsAttribute(ATTRIBUTE_DARK)
		and aux.MustMaterialCheck(c,tp,EFFECT_MUST_BE_XMATERIAL)
		and Duel.IsExistingMatchingCard(s.xyzfilter,tp,LOCATION_EXTRA,0,1,nil,e,tp,c,c:GetRank())
end
function s.xyzfilter(c,e,tp,mc,rk)
	if c:GetOriginalCode()==6165656 and not mc:IsCode(48995978) then return false end
	return c:IsRank(rk+1) and c:IsSetCard(0x10db,0x2073) and mc:IsCanBeXyzMaterial(c)
		and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_XYZ,tp,false,false) and Duel.GetLocationCountFromEx(tp,tp,mc,c)>0
end
function s.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local g=Duel.GetMatchingGroup(s.cfilter,tp,LOCATION_MZONE,0,nil,tp)
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_GRAVE+LOCATION_REMOVED) and s.spfilter(chkc,e,tp,g) end
	if chk==0 then return Duel.IsPlayerCanSpecialSummonCount(tp,2)
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and aux.MustMaterialCheck(nil,tp,EFFECT_MUST_BE_XMATERIAL)
		and Duel.IsExistingTarget(s.spfilter,tp,LOCATION_GRAVE+LOCATION_REMOVED,0,1,nil,e,tp,g) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local sg=Duel.SelectTarget(tp,s.spfilter,tp,LOCATION_GRAVE+LOCATION_REMOVED,0,1,1,nil,e,tp,g)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,sg,2,tp,LOCATION_EXTRA)
end
function s.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	local tc=Duel.GetFirstTarget()
	if not tc:IsRelateToChain() or tc:IsImmuneToEffect(e) or not aux.NecroValleyFilter()(tc) then return end
	if Duel.SpecialSummonStep(tc,0,tp,tp,false,false,POS_FACEUP) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_DISABLE)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_DISABLE_EFFECT)
		e2:SetValue(RESET_TURN_SET)
		e2:SetReset(RESET_EVENT+RESETS_STANDARD)
		tc:RegisterEffect(e2)
	else
		return
	end
	Duel.SpecialSummonComplete()
	if not aux.MustMaterialCheck(tc,tp,EFFECT_MUST_BE_XMATERIAL) then return end
	Duel.AdjustAll()
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_XMATERIAL)
	local g=Duel.SelectMatchingCard(tp,s.stfilter,tp,LOCATION_MZONE,0,1,1,nil,e,tp)
	local xc=g:GetFirst()
	if xc then
		Duel.BreakEffect()
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local sg=Duel.SelectMatchingCard(tp,s.xyzfilter,tp,LOCATION_EXTRA,0,1,1,nil,e,tp,xc,xc:GetRank())
		local sc=sg:GetFirst()
		if sc then
			Duel.BreakEffect()
			local mg=xc:GetOverlayGroup()
			if mg:GetCount()~=0 then
				Duel.Overlay(sc,mg)
			end
			sc:SetMaterial(Group.FromCards(xc))
			Duel.Overlay(sc,Group.FromCards(xc))
			Duel.SpecialSummon(sc,SUMMON_TYPE_XYZ,tp,tp,false,false,POS_FACEUP)
			sc:CompleteProcedure()
		end
	end
end
