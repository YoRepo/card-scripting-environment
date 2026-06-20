--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 玻璃铠  (ID: 36868108)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 装备卡给怪兽装备时才能发动。直到回合结束时场上的全部装备卡的效果无效。
--[[ __CARD_HEADER_END__ ]]

--ガラスの鎧
function c36868108.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_EQUIP)
	e1:SetOperation(c36868108.activate)
	c:RegisterEffect(e1)
end
function c36868108.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	--disable
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_DISABLE)
	e1:SetTargetRange(LOCATION_SZONE,LOCATION_SZONE)
	e1:SetTarget(c36868108.distarget)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c36868108.distarget(e,c)
	return c:IsType(TYPE_EQUIP)
end
