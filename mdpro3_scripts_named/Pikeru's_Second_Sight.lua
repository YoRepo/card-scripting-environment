--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:31
-- Card: 绒儿的读心术  (ID: 58015506)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 直到对方第2个回合的结束阶段前，对方玩家的抽卡先公开再加入手卡。
--[[ __CARD_HEADER_END__ ]]

--ピケルの読心術
function c58015506.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetOperation(c58015506.activate)
	c:RegisterEffect(e1)
end
function c58015506.activate(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_DRAW)
	e1:SetOperation(c58015506.cfop)
	e1:SetReset(RESET_PHASE+PHASE_END+RESET_OPPO_TURN,2)
	Duel.RegisterEffect(e1,tp)
end
function c58015506.cfop(e,tp,eg,ep,ev,re,r,rp)
	if ep==e:GetOwnerPlayer() then return end
	Duel.ConfirmCards(1-ep,eg)
end
