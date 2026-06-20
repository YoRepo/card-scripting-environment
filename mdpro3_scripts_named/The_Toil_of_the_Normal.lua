--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 一色万骨  (ID: 83404468)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张。
-- ①：自己墓地的通常怪兽种类的以下效果各适用。
-- ●1种类以上：这个回合中，自己场上的通常怪兽的攻击力上升800。
-- ●2种类以上：场上1只效果怪兽的效果直到回合结束时无效。
-- ●3种类以上：这个回合中，自己场上的通常怪兽不会被效果破坏。
-- ●4种类以上：场上1只效果怪兽回到卡组。
-- ●5种类以上：从卡组把1张「一色万骨」加入手卡。
--[[ __CARD_HEADER_END__ ]]

--一色万骨
local s,id,o=GetID()
function s.initial_effect(c)
	aux.AddCodeList(c,id)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DISABLE+CATEGORY_SEARCH+CATEGORY_TOHAND+CATEGORY_TODECK)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e1:SetHintTiming(TIMING_DAMAGE_STEP,TIMING_DAMAGE_STEP+TIMINGS_CHECK_MONSTER+TIMING_END_PHASE)
	e1:SetCountLimit(1,id+EFFECT_COUNT_CODE_OATH)
	e1:SetTarget(s.target)
	e1:SetOperation(s.activate)
	c:RegisterEffect(e1)
end
function s.cfilter(c)
	return c:IsAllTypes(TYPE_NORMAL+TYPE_MONSTER)
end
function s.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local g=Duel.GetMatchingGroup(s.cfilter,tp,LOCATION_GRAVE,0,nil)
	if chk==0 then return g:GetCount()>0 end
end
function s.tdfilter(c)
	return c:IsFaceup() and c:IsAllTypes(TYPE_EFFECT+TYPE_MONSTER) and c:IsAbleToDeck()
end
function s.thfilter(c)
	return c:IsCode(id) and c:IsAbleToHand()
end
function s.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=Duel.GetMatchingGroup(s.cfilter,tp,LOCATION_GRAVE,0,nil)
	local op=g:GetClassCount(Card.GetCode)
	if op>0 then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetTargetRange(LOCATION_MZONE,0)
		e1:SetTarget(s.atktg)
		e1:SetValue(800)
		e1:SetReset(RESET_PHASE+PHASE_END)
		Duel.RegisterEffect(e1,tp)
	end
	if op>1 and Duel.IsExistingMatchingCard(aux.NegateEffectMonsterFilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) then
		Duel.BreakEffect()
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DISABLE)
		local sg=Duel.SelectMatchingCard(tp,aux.NegateEffectMonsterFilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
		Duel.HintSelection(sg)
		local tc=sg:GetFirst()
		Duel.NegateRelatedChain(tc,RESET_TURN_SET)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e2:SetCode(EFFECT_DISABLE)
		e2:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e2)
		local e3=Effect.CreateEffect(c)
		e3:SetType(EFFECT_TYPE_SINGLE)
		e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e3:SetCode(EFFECT_DISABLE_EFFECT)
		e3:SetValue(RESET_TURN_SET)
		e3:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e3)
	end
	if op>2 then
		local e5=Effect.CreateEffect(e:GetHandler())
		e5:SetType(EFFECT_TYPE_FIELD)
		e5:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
		e5:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
		e5:SetTargetRange(LOCATION_MZONE,0)
		e5:SetTarget(s.atktg)
		e5:SetValue(1)
		e5:SetReset(RESET_PHASE+PHASE_END)
		Duel.RegisterEffect(e5,tp)
	end
	if op>3 and Duel.IsExistingMatchingCard(s.tdfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) then
		local sg=Duel.GetMatchingGroup(s.tdfilter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
		if sg:GetCount()>0 then
			Duel.BreakEffect()
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
			local ssg=sg:Select(tp,1,1,nil)
			Duel.HintSelection(ssg)
			Duel.SendtoDeck(ssg,nil,SEQ_DECKSHUFFLE,REASON_EFFECT)
		end
	end
	if op>4 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local sg=Duel.SelectMatchingCard(tp,s.thfilter,tp,LOCATION_DECK,0,1,1,nil)
		if sg:GetCount()>0 then
			Duel.BreakEffect()
			Duel.SendtoHand(sg,nil,REASON_EFFECT)
			Duel.ConfirmCards(1-tp,sg)
		end
	end
end
function s.atktg(e,c)
	return c:IsAllTypes(TYPE_NORMAL+TYPE_MONSTER) and c:IsFaceup()
end
