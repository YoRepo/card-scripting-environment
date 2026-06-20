--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 天邪鬼的诅咒  (ID: 77622396)
-- Type: Trap
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 直到发动回合的结束阶段时，攻击力·守备力的上升·下降的效果变成相反。
--[[ __CARD_HEADER_END__ ]]

--あまのじゃくの呪い
function c77622396.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetOperation(c77622396.activate)
	c:RegisterEffect(e1)
end
function c77622396.activate(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_REVERSE_UPDATE)
	e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e1:SetReset(RESET_PHASE+PHASE_END)
	e1:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	Duel.RegisterEffect(e1,tp)
end
