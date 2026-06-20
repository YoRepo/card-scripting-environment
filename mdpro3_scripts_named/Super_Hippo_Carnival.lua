--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 超河马狂欢节  (ID: 11050415)
-- Type: Spell / Continuous
-- ATK 0 | DEF 0
--
-- Effect Text:
-- ①：从自己的手卡·卡组·墓地选1只「娱乐伙伴 探寻河马」特殊召唤。那之后，可以在自己场上把「河马衍生物」（兽族·地·1星·攻/守0）尽可能特殊召唤。这衍生物不能解放。只要「河马衍生物」在怪兽区域存在，
-- 自己不能从额外卡组把怪兽特殊召唤。这个效果把「河马衍生物」特殊召唤的场合，直到回合结束时对方不能把「河马衍生物」以外的怪兽作为攻击对象。
--[[ __CARD_HEADER_END__ ]]

--超カバーカーニバル
function c11050415.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c11050415.target)
	e1:SetOperation(c11050415.activate)
	c:RegisterEffect(e1)
end
function c11050415.filter(c,e,tp)
	return c:IsCode(41440148) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c11050415.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c11050415.filter,tp,0x13,0,1,nil,e,tp) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,0x13)
end
function c11050415.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(c11050415.filter),tp,0x13,0,1,1,nil,e,tp)
	if g:GetCount()>0 then
		if Duel.SpecialSummon(g,0,tp,tp,false,false,POS_FACEUP)==0 then return end
		local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
		if ft<=0 or (Duel.IsPlayerAffectedByEffect(tp,59822133) and ft>1) then return end
		if Duel.IsPlayerCanSpecialSummonMonster(tp,18027139,0,TYPES_TOKEN_MONSTER,0,0,1,RACE_BEAST,ATTRIBUTE_EARTH)
			and Duel.SelectYesNo(tp,aux.Stringid(11050415,0)) then
			Duel.BreakEffect()
			local c=e:GetHandler()
			for i=1,ft do
				local token=Duel.CreateToken(tp,11050415+i)
				Duel.SpecialSummonStep(token,0,tp,tp,false,false,POS_FACEUP)
				local e1=Effect.CreateEffect(c)
				e1:SetType(EFFECT_TYPE_SINGLE)
				e1:SetCode(EFFECT_UNRELEASABLE_SUM)
				e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
				e1:SetValue(1)
				e1:SetReset(RESET_EVENT+RESETS_STANDARD)
				token:RegisterEffect(e1)
				local e2=e1:Clone()
				e2:SetCode(EFFECT_UNRELEASABLE_NONSUM)
				token:RegisterEffect(e2)
				local e3=Effect.CreateEffect(c)
				e3:SetType(EFFECT_TYPE_FIELD)
				e3:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
				e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
				e3:SetRange(LOCATION_MZONE)
				e3:SetAbsoluteRange(tp,1,0)
				e3:SetTarget(c11050415.splimit)
				e3:SetReset(RESET_EVENT+RESETS_STANDARD)
				token:RegisterEffect(e3)
			end
			Duel.SpecialSummonComplete()
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_FIELD)
			e1:SetCode(EFFECT_CANNOT_SELECT_BATTLE_TARGET)
			e1:SetTargetRange(0,LOCATION_MZONE)
			e1:SetValue(c11050415.atlimit)
			e1:SetReset(RESET_PHASE+PHASE_END)
			Duel.RegisterEffect(e1,tp)
		end
	end
end
function c11050415.splimit(e,c)
	return c:IsLocation(LOCATION_EXTRA)
end
function c11050415.atlimit(e,c)
	return not c:IsCode(18027139)
end
