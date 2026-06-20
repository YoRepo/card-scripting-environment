--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 白骨夫人  (ID: 40991587)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Zombie
-- Level 3
-- ATK 0 | DEF 2200
--
-- Effect Text:
-- 这张卡的卡名只要在墓地存在当作「白骨」使用。此外，只要这张卡在场上表侧表示存在，「白骨夫人」以外的场上的3星以下的不死族怪兽不会被战斗破坏，也不受魔法·陷阱卡的效果影响。
--[[ __CARD_HEADER_END__ ]]

--ワイト夫人
function c40991587.initial_effect(c)
	--change code
	aux.EnableChangeCode(c,32274490,LOCATION_GRAVE)
	--battle indestructable
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e2:SetTarget(c40991587.etarget)
	e2:SetValue(1)
	c:RegisterEffect(e2)
	--immune
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_IMMUNE_EFFECT)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e3:SetTarget(c40991587.etarget)
	e3:SetValue(c40991587.efilter)
	c:RegisterEffect(e3)
end
function c40991587.etarget(e,c)
	return not c:IsCode(40991587) and c:IsRace(RACE_ZOMBIE) and c:IsLevelBelow(3)
end
function c40991587.efilter(e,te)
	return te:IsActiveType(TYPE_SPELL+TYPE_TRAP) and not te:GetHandler():IsCode(4064256)
end
