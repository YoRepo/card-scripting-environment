--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 危险机器 6型  (ID: 76895648)
-- Type: Spell / Equip
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 每次自己的准备阶段丢1个骰子，根据丢出的数目决定效果。
-- ●投掷1的场合：自己丢弃1张手卡。
-- ●投掷2的场合：对方丢弃1张手卡。
-- ●投掷3的场合：自己抽1张卡。
-- ●投掷4的场合：对方抽1张卡。
-- ●投掷5的场合：对方的场上1只怪兽破坏。
-- ●投掷6的场合：这张卡破坏。
--[[ __CARD_HEADER_END__ ]]

--デンジャラスマシン TYPE－6
function c76895648.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--dice
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(76895648,0))
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetCategory(CATEGORY_DICE+CATEGORY_ATKCHANGE+CATEGORY_DRAW)
	e2:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1)
	e2:SetCondition(c76895648.condition)
	e2:SetTarget(c76895648.target)
	e2:SetOperation(c76895648.operation)
	c:RegisterEffect(e2)
end
function c76895648.condition(e,tp,eg,ep,ev,re,r,rp)
	return tp==Duel.GetTurnPlayer()
end
function c76895648.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DICE,nil,0,tp,1)
end
function c76895648.operation(e,tp,eg,ep,ev,re,r,rp)
	local dice=Duel.TossDice(tp,1)
	if dice==1 then
		Duel.DiscardHand(tp,nil,1,1,REASON_EFFECT+REASON_DISCARD)
	elseif dice==2 then
		Duel.DiscardHand(1-tp,nil,1,1,REASON_EFFECT+REASON_DISCARD)
	elseif dice==3 then
		Duel.Draw(tp,1,REASON_EFFECT)
	elseif dice==4 then
		Duel.Draw(1-tp,1,REASON_EFFECT)
	elseif dice==5 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
		local g=Duel.SelectMatchingCard(tp,aux.TRUE,tp,0,LOCATION_MZONE,1,1,nil)
		Duel.Destroy(g,REASON_EFFECT)
	elseif dice==6 then
		Duel.Destroy(e:GetHandler(),REASON_EFFECT)
	end
end
