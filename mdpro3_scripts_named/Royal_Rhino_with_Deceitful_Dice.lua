--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 犀子国王  (ID: 74289646)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Beast
-- Level 1
-- ATK 600 | DEF 600
--
-- Effect Text:
-- ①：1回合1次，卡的效果发动时才能发动（伤害步骤也能发动）。掷1次骰子。这个效果的发动时积累的连锁数量的以下效果适用。
-- ●2个：这张卡的攻击力直到回合结束时上升出现的数目×500。
-- ●3个：给与对方为出现的数目×500伤害。
-- ●4个以上：把最多有出现的数目数量的场上的卡破坏。
--[[ __CARD_HEADER_END__ ]]

--犀子の王様
function c74289646.initial_effect(c)
	--dice
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCategory(CATEGORY_DICE+CATEGORY_ATKCHANGE+CATEGORY_DAMAGE+CATEGORY_DESTROY)
	e1:SetCode(EVENT_CHAINING)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetTarget(c74289646.target)
	e1:SetOperation(c74289646.operation)
	c:RegisterEffect(e1)
end
function c74289646.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local cl=Duel.GetCurrentChain()
	if chk==0 then return true end
	if cl==2 then
		e:SetCategory(CATEGORY_DICE+CATEGORY_ATKCHANGE)
	end
	if cl==3 then
		e:SetCategory(CATEGORY_DICE+CATEGORY_DAMAGE)
		e:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_PLAYER_TARGET)
		Duel.SetTargetPlayer(1-tp)
		Duel.SetOperationInfo(0,CATEGORY_DICE,nil,0,tp,1)
		Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,0)
	end
	if cl>=4 then
		e:SetCategory(CATEGORY_DICE+CATEGORY_DESTROY)
		local g=Duel.GetMatchingGroup(aux.TRUE,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
	end
end
function c74289646.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local cl=Duel.GetCurrentChain()
	local d=Duel.TossDice(tp,1)
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	local g=Duel.GetMatchingGroup(aux.TRUE,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,nil)
	if cl==2 and c:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		e1:SetValue(d*500)
		c:RegisterEffect(e1)
	end
	if cl==3 then
		Duel.Damage(p,d*500,REASON_EFFECT)
	end
	if cl>=4 and g:GetCount()>0 then
		local ct=math.min(g:GetCount(),d)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
		local sg=g:Select(tp,1,ct,nil)
		Duel.HintSelection(sg)
		Duel.Destroy(sg,REASON_EFFECT)
	end
end
