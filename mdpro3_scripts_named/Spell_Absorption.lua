--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:29
-- Card: 魔法吸收  (ID: 51481927)
-- Type: Spell / Equip
-- ATK 0 | DEF 0
--
-- Effect Text:
-- ①：只要这张卡在魔法与陷阱区域存在，每次自己或者对方把魔法卡发动，自己回复500基本分。
--[[ __CARD_HEADER_END__ ]]

--魔法吸収
function c51481927.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--LP up
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e0:SetCode(EVENT_CHAINING)
	e0:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e0:SetRange(LOCATION_SZONE)
	e0:SetOperation(aux.chainreg)
	c:RegisterEffect(e0)
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(51481927,0))
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_CHAIN_SOLVED)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCondition(c51481927.condition)
	e2:SetOperation(c51481927.operation)
	c:RegisterEffect(e2)
end
function c51481927.condition(e,tp,eg,ep,ev,re,r,rp)
	return re and re:IsActiveType(TYPE_SPELL) and re:IsHasType(EFFECT_TYPE_ACTIVATE)
		and re:GetHandler()~=e:GetHandler() and e:GetHandler():GetFlagEffect(FLAG_ID_CHAINING)>0
end
function c51481927.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Recover(e:GetHandlerPlayer(),500,REASON_EFFECT)
end
