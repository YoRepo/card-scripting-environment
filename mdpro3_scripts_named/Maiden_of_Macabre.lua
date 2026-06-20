--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 艺妓之影  (ID: 84055227)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Spellcaster
-- Level 4
-- ATK 1700 | DEF 0
--
-- Effect Text:
-- ①：这张卡战斗破坏对方怪兽的场合发动。给这张卡放置1个魔力指示物。
-- ②：这张卡的攻击力上升这张卡的魔力指示物数量×200。
--[[ __CARD_HEADER_END__ ]]

--ゲイシャドウ
function c84055227.initial_effect(c)
	c:EnableCounterPermit(0x1)
	--add counter
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(84055227,0))
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_BATTLE_DESTROYING)
	e1:SetCondition(c84055227.condition)
	e1:SetOperation(c84055227.operation)
	c:RegisterEffect(e1)
	--attackup
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetValue(c84055227.attackup)
	c:RegisterEffect(e2)
end
function c84055227.condition(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsRelateToBattle() and c:GetBattleTarget():IsType(TYPE_MONSTER)
end
function c84055227.operation(e,tp,eg,ep,ev,re,r,rp)
	e:GetHandler():AddCounter(0x1,1)
end
function c84055227.attackup(e,c)
	return c:GetCounter(0x1)*200
end
