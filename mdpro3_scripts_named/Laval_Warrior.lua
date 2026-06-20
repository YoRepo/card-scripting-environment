--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:30
-- Card: 熔岩战士  (ID: 52786469)
-- Type: Monster / Effect
-- Attribute: FIRE
-- Race: Warrior
-- Level 4
-- ATK 1800 | DEF 500
-- Setcode: 6684729
--
-- Effect Text:
-- 这张卡战斗破坏对方怪兽的场合自己墓地有名字带有「熔岩」的怪兽4种类以上存在的场合，给与对方基本分那次战斗破坏的怪兽的攻击力数值的伤害。
--[[ __CARD_HEADER_END__ ]]

--ラヴァル・ウォリアー
function c52786469.initial_effect(c)
	--damage
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(52786469,0))
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetCode(EVENT_BATTLE_DESTROYING)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCondition(c52786469.condition)
	e1:SetTarget(c52786469.target)
	e1:SetOperation(c52786469.operation)
	c:RegisterEffect(e1)
end
function c52786469.condition(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	e:SetLabel(bc:GetAttack())
	return c:IsRelateToBattle() and bc:IsType(TYPE_MONSTER)
end
function c52786469.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(e:GetLabel())
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,e:GetLabel())
end
function c52786469.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetMatchingGroup(Card.IsSetCard,tp,LOCATION_GRAVE,0,nil,0x39):GetClassCount(Card.GetCode)<4 then return end
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end
