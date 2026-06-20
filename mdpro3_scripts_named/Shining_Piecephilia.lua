--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 拼图友爱天使  (ID: 49776811)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Rock
-- Level 4
-- ATK 700 | DEF 2000
--
-- Effect Text:
-- ①：这张卡不会被战斗破坏。
-- ②：这张卡和对方怪兽进行战斗的伤害步骤结束时才能发动。给这张卡放置1个拼图指示物（最多4个）。那之后，可以让这张卡的拼图指示物数量的以下效果适用。
-- ●1个：从卡组选1只怪兽在卡组最上面放置。
-- ●2个：自己从卡组抽1张。
-- ●3个：从卡组把1只怪兽加入手卡。
-- ●4个：从卡组选1张卡加入手卡。
--[[ __CARD_HEADER_END__ ]]

--ピースリア
function c49776811.initial_effect(c)
	c:EnableCounterPermit(0x5f)
	c:SetCounterLimit(0x5f,4)
	--battle indes
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e1:SetValue(1)
	c:RegisterEffect(e1)
	--add counter
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_COUNTER+CATEGORY_DRAW+CATEGORY_TOHAND+CATEGORY_SEARCH)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_DAMAGE_STEP_END)
	e2:SetTarget(c49776811.cttg)
	e2:SetOperation(c49776811.ctop)
	c:RegisterEffect(e2)
end
function c49776811.cttg(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=e:GetHandler():GetBattleTarget()
	if chk==0 then return tc and e:GetHandler():IsCanAddCounter(0x5f,1) end
	Duel.SetOperationInfo(0,CATEGORY_COUNTER,nil,1,0,0x5f)
end
function c49776811.ctop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:IsFaceup() then
		c:AddCounter(0x5f,1)
		local ct=c:GetCounter(0x5f)
		local dg=Duel.GetMatchingGroup(Card.IsType,tp,LOCATION_DECK,0,nil,TYPE_MONSTER)
		if ct==1 and dg:GetCount()>0 and Duel.SelectYesNo(tp,aux.Stringid(49776811,0)) then
			Duel.BreakEffect()
			Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(49776811,4))
			local g=dg:Select(tp,1,1,nil)
			local tc=g:GetFirst()
			if tc then
				Duel.ShuffleDeck(tp)
				Duel.MoveSequence(tc,SEQ_DECKTOP)
				Duel.ConfirmDecktop(tp,1)
			end
		end
		if ct==2 and Duel.IsPlayerCanDraw(tp,1) and Duel.SelectYesNo(tp,aux.Stringid(49776811,1)) then
			Duel.BreakEffect()
			Duel.Draw(tp,1,REASON_EFFECT)
		end
		local mg=Duel.GetMatchingGroup(c49776811.mfilter,tp,LOCATION_DECK,0,nil)
		if ct==3 and mg:GetCount()>0 and Duel.SelectYesNo(tp,aux.Stringid(49776811,2)) then
			Duel.BreakEffect()
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
			local g=mg:Select(tp,1,1,nil)
			if g:GetCount()>0 then
				Duel.SendtoHand(g,nil,REASON_EFFECT)
				Duel.ConfirmCards(1-tp,g)
			end
		end
		local cg=Duel.GetMatchingGroup(Card.IsAbleToHand,tp,LOCATION_DECK,0,nil)
		if ct==4 and cg:GetCount()>0 and Duel.SelectYesNo(tp,aux.Stringid(49776811,3)) then
			Duel.BreakEffect()
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
			local g=cg:Select(tp,1,1,nil)
			if g:GetCount()>0 then
				g:GetFirst():SetStatus(STATUS_TO_HAND_WITHOUT_CONFIRM,true)
				Duel.SendtoHand(g,nil,REASON_EFFECT)
			end
		end
	end
end
function c49776811.mfilter(c)
	return c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
end
