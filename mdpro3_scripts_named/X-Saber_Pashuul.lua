--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: X-剑士 珀修尔  (ID: 23093604)
-- Type: Monster / Effect / Tuner
-- Attribute: EARTH
-- Race: Warrior
-- Level 2
-- ATK 100 | DEF 0
-- Setcode: 4109
--
-- Effect Text:
-- ①：这张卡不会被战斗破坏。
-- ②：对方准备阶段发动。自己受到1000伤害。这个效果在这张卡在怪兽区域表侧守备表示存在的场合进行发动和处理。
--[[ __CARD_HEADER_END__ ]]

--X－セイバー パシウル
function c23093604.initial_effect(c)
	--damage
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(23093604,0))
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCondition(c23093604.condition)
	e1:SetTarget(c23093604.target)
	e1:SetOperation(c23093604.operation)
	c:RegisterEffect(e1)
	--battle indestructable
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e2:SetValue(1)
	c:RegisterEffect(e2)
end
function c23093604.condition(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsFaceup() and e:GetHandler():IsDefensePos() and Duel.GetTurnPlayer()~=tp
end
function c23093604.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(1000)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,0,0,tp,1000)
end
function c23093604.operation(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) or not e:GetHandler():IsPosition(POS_FACEUP_DEFENSE) then return end
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end
