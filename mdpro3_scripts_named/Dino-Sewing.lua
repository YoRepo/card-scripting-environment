--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 缝制恐龙  (ID: 27143874)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Fiend
-- Level 4
-- ATK 0 | DEF 0
--
-- Effect Text:
-- ①：这张卡不会被战斗破坏。
-- ②：这张卡被选择作为攻击对象的场合发动。这张卡的攻击力·守备力上升1000。
-- ③：这张卡攻击的伤害计算后发动。这张卡的②的效果上升的数值回到0。
--[[ __CARD_HEADER_END__ ]]

--ダイナソーイング
function c27143874.initial_effect(c)
	--indes
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e1:SetValue(1)
	c:RegisterEffect(e1)
	--atk/def up
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(27143874,0))
	e2:SetCategory(CATEGORY_ATKCHANGE+CATEGORY_DEFCHANGE)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_BE_BATTLE_TARGET)
	e2:SetOperation(c27143874.operation)
	c:RegisterEffect(e2)
	--atk clear
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(27143874,1))
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e3:SetCode(EVENT_BATTLED)
	e3:SetCondition(c27143874.retcon)
	e3:SetOperation(c27143874.retop)
	c:RegisterEffect(e3)
end
function c27143874.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:IsFaceup() then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(1000)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE)
		c:RegisterEffect(e1)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_UPDATE_DEFENSE)
		c:RegisterEffect(e2)
	end
end
function c27143874.retcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttacker()==e:GetHandler()
end
function c27143874.retop(e,tp,eg,ep,ev,re,r,rp)
	e:GetHandler():ResetEffect(RESET_DISABLE,RESET_EVENT)
end
