--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 娱乐伙伴 鱼饵大头龟  (ID: 89113320)
-- Type: Monster / Effect / Pendulum
-- Attribute: WATER
-- Race: Reptile
-- Level 3
-- Pendulum Scales: L3 / R3
-- ATK 800 | DEF 1200
-- Setcode: 159
--
-- Effect Text:
-- ←3 【灵摆】 3→
-- ①：1回合1次，自己主要阶段才能发动。手卡1只「娱乐伙伴」怪兽或者「异色眼」怪兽给对方观看。这个回合，那只怪兽以及自己手卡的同名怪兽的等级下降1星。
-- 【怪兽效果】
-- ①：这张卡被战斗破坏时才能发动。把让这张卡破坏的怪兽破坏。
--[[ __CARD_HEADER_END__ ]]

--EMビッグバイトタートル
function c89113320.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--lv
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(89113320,0))
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_PZONE)
	e2:SetCountLimit(1)
	e2:SetTarget(c89113320.lvtg)
	e2:SetOperation(c89113320.lvop)
	c:RegisterEffect(e2)
	--
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(89113320,1))
	e3:SetCategory(CATEGORY_DESTROY)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_BATTLE_DESTROYED)
	e3:SetTarget(c89113320.target)
	e3:SetOperation(c89113320.operation)
	c:RegisterEffect(e3)
end
function c89113320.filter(c)
	return c:IsSetCard(0x9f,0x99) and c:IsType(TYPE_MONSTER)
end
function c89113320.lvtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c89113320.filter,tp,LOCATION_HAND,0,1,e:GetHandler()) end
end
function c89113320.lvop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONFIRM)
	local g=Duel.SelectMatchingCard(tp,c89113320.filter,tp,LOCATION_HAND,0,1,1,nil)
	Duel.ConfirmCards(1-tp,g)
	Duel.ShuffleHand(tp)
	local hg=Duel.GetMatchingGroup(Card.IsCode,tp,LOCATION_HAND,0,nil,g:GetFirst():GetCode())
	local tc=hg:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_LEVEL)
		e1:SetValue(-1)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD-RESET_TOFIELD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
		tc=hg:GetNext()
	end
end
function c89113320.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local bc=e:GetHandler():GetBattleTarget()
	if chk==0 then return bc:IsRelateToBattle() end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,bc,1,0,0)
end
function c89113320.operation(e,tp,eg,ep,ev,re,r,rp)
	local bc=e:GetHandler():GetBattleTarget()
	if bc:IsRelateToBattle() then
		Duel.Destroy(bc,REASON_EFFECT)
	end
end
