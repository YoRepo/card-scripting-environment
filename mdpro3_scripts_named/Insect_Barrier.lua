--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 除虫网  (ID: 23615409)
-- Type: Spell / Equip
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 对方场上存在的全部昆虫族的怪兽不能宣言攻击。
--[[ __CARD_HEADER_END__ ]]

--虫除けバリアー
function c23615409.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--cannot attack
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CANNOT_ATTACK_ANNOUNCE)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(0,LOCATION_MZONE)
	e2:SetTarget(c23615409.atktarget)
	c:RegisterEffect(e2)
end
function c23615409.atktarget(e,c)
	return c:IsRace(RACE_INSECT)
end
