--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:46
-- Source DB: cards.cdb
-- Card: Toon Defense  (ID: 43509019)
-- Type: Trap / Continuous
-- Setcode: 0x62
-- Scope: OCG / TCG
--
-- Effect Text:
-- When an opponent's monster declares an attack targeting a face-up Level 4 or lower Toon monster you
-- control: You can make the attack a direct attack instead.
--[[ __CARD_HEADER_END__ ]]

--トゥーン・ディフェンス
function c43509019.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--change battle target
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(43509019,0))
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_ATTACK_ANNOUNCE)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCondition(c43509019.cbcon)
	e2:SetTarget(c43509019.cbtg)
	e2:SetOperation(c43509019.cbop)
	c:RegisterEffect(e2)
end
function c43509019.cbcon(e,tp,eg,ep,ev,re,r,rp)
	local bt=Duel.GetAttackTarget()
	return bt and bt:IsFaceup() and bt:IsLevelBelow(4) and bt:IsType(TYPE_TOON) and bt:GetControler()==e:GetHandlerPlayer()
end
function c43509019.cbtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return not Duel.GetAttacker():IsHasEffect(EFFECT_CANNOT_DIRECT_ATTACK) end
end
function c43509019.cbop(e,tp,eg,ep,ev,re,r,rp)
	Duel.ChangeAttackTarget(nil)
end
