--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 绝对的捕食  (ID: 25573115)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张。
-- ①：通常召唤的怪兽在自己场上存在的场合才能发动。场上的特殊召唤的怪兽全部破坏。这张卡的发动后，直到下次的自己回合的结束时自己不能通常召唤。
--[[ __CARD_HEADER_END__ ]]

--絶対なる捕食
function c25573115.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(25573115,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,25573115+EFFECT_COUNT_CODE_OATH)
	e1:SetHintTiming(0,TIMINGS_CHECK_MONSTER+TIMING_END_PHASE)
	e1:SetCondition(c25573115.condition)
	e1:SetTarget(c25573115.target)
	e1:SetOperation(c25573115.activate)
	c:RegisterEffect(e1)
end
function c25573115.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(Card.IsSummonType,tp,LOCATION_MZONE,0,1,nil,SUMMON_TYPE_NORMAL)
end
function c25573115.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=Duel.GetMatchingGroup(Card.IsSummonType,tp,LOCATION_MZONE,LOCATION_MZONE,nil,SUMMON_TYPE_SPECIAL)
	if chk==0 then return #g>0 end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,#g,0,0)
end
function c25573115.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if e:IsHasType(EFFECT_TYPE_ACTIVATE) then
		local ct=(Duel.GetTurnPlayer()==tp) and 2 or 1
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetCode(EFFECT_CANNOT_SUMMON)
		e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
		e1:SetReset(RESET_PHASE+PHASE_END+RESET_SELF_TURN,ct)
		e1:SetTargetRange(1,0)
		Duel.RegisterEffect(e1,tp)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_CANNOT_MSET)
		Duel.RegisterEffect(e2,tp)
	end
	local g=Duel.GetMatchingGroup(Card.IsSummonType,tp,LOCATION_MZONE,LOCATION_MZONE,nil,SUMMON_TYPE_SPECIAL)
	if #g>0 then
		Duel.Destroy(g,REASON_EFFECT)
	end
end
