--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:54
-- Source DB: cards.cdb
-- Card: Howl of the Wild  (ID: 97922283)
-- Type: Trap / Continuous
-- Scope: OCG / TCG
--
-- Effect Text:
-- If your monster destroys an opponent's monster by battle and sends it to the GY: Inflict 300 damage
-- to your opponent for each Beast monster you control.
--[[ __CARD_HEADER_END__ ]]

--野生の咆哮
function c97922283.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--no damage & spsummon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(97922283,0))
	e2:SetCategory(CATEGORY_DAMAGE)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_BATTLE_DESTROYING)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCondition(c97922283.condition)
	e2:SetTarget(c97922283.target)
	e2:SetOperation(c97922283.operation)
	c:RegisterEffect(e2)
end
function c97922283.condition(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	local bc=tc:GetBattleTarget()
	return tc:IsRelateToBattle() and tc:IsControler(tp)
		and bc:IsLocation(LOCATION_GRAVE) and bc:IsReason(REASON_BATTLE) and bc:IsType(TYPE_MONSTER)
end
function c97922283.filter(c)
	return c:IsFaceup() and c:IsRace(RACE_BEAST)
end
function c97922283.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(1-tp)
	local dam=Duel.GetMatchingGroupCount(c97922283.filter,tp,LOCATION_MZONE,0,nil)*300
	Duel.SetTargetParam(dam)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,dam)
end
function c97922283.operation(e,tp,eg,ep,ev,re,r,rp)
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	local dam=Duel.GetMatchingGroupCount(c97922283.filter,tp,LOCATION_MZONE,0,nil)*300
	Duel.Damage(p,dam,REASON_EFFECT)
end
