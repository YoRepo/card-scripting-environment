--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 战士猿  (ID: 41098335)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Beast
-- Level 4
-- ATK 1900 | DEF 1200
--
-- Effect Text:
-- 这张卡战斗破坏对方怪兽的场合，这张卡的攻击力上升300。这张卡在自己回合没有进行攻击的场合，这个效果上升的数值在那个回合的结束阶段时回到0。
--[[ __CARD_HEADER_END__ ]]

--ファイターズ・エイプ
function c41098335.initial_effect(c)
	--atkup
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(41098335,0))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_BATTLE_DESTROYING)
	e1:SetCondition(c41098335.atkcon)
	e1:SetOperation(c41098335.atkop)
	c:RegisterEffect(e1)
	--atk clear
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_TURN_END)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetOperation(c41098335.retop)
	c:RegisterEffect(e2)
end
function c41098335.atkcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsFaceup() and e:GetHandler():IsRelateToBattle()
end
function c41098335.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:IsFaceup() then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(300)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE)
		c:RegisterEffect(e1)
	end
end
function c41098335.retop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if Duel.GetTurnPlayer()==tp and c:GetAttackedCount()==0 then
		c:ResetEffect(RESET_DISABLE,RESET_EVENT)
	end
end
