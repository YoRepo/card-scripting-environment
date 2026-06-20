--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:30
-- Card: 戈耳工之眼  (ID: 52648457)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 结束阶段结束前，场上存在的守备表示的怪兽的效果无效化。
--[[ __CARD_HEADER_END__ ]]

--ゴーゴンの眼
function c52648457.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetOperation(c52648457.activate)
	c:RegisterEffect(e1)
end
function c52648457.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	--disable
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_DISABLE)
	e1:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e1:SetTarget(c52648457.distg)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c52648457.distg(e,c)
	return c:IsDefensePos()
end
