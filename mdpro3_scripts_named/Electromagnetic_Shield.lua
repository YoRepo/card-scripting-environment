--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:36
-- Card: 电磁盾  (ID: 91107093)
-- Type: Spell / Equip
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 自己场上表侧守备表示存在的3星以下的雷族怪兽不会被战斗破坏。自己场上有怪兽表侧攻击表示存在的场合，这张卡破坏。
--[[ __CARD_HEADER_END__ ]]

--電磁シールド
function c91107093.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--indestructable
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetTarget(c91107093.infilter)
	e2:SetValue(1)
	c:RegisterEffect(e2)
	--self destroy
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetRange(LOCATION_SZONE)
	e3:SetCode(EFFECT_SELF_DESTROY)
	e3:SetCondition(c91107093.descon)
	c:RegisterEffect(e3)
end
function c91107093.infilter(e,c)
	return c:IsDefensePos() and c:IsLevelBelow(3) and c:IsRace(RACE_THUNDER)
end
function c91107093.filter(c)
	return c:IsFaceup() and c:IsAttackPos()
end
function c91107093.descon(e)
	return Duel.IsExistingMatchingCard(c91107093.filter,e:GetHandlerPlayer(),LOCATION_MZONE,0,1,nil)
end
