--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:51
-- Source DB: cards.cdb
-- Card: Supreme King's Castle  (ID: 72043279)
-- Type: Spell / Field
-- Scope: OCG / TCG
--
-- Effect Text:
-- You can Fusion Summon Fusion Monsters that must be Special Summoned with "Dark Fusion", with effects
-- other than "Dark Fusion".
-- Once per turn, during damage calculation, if your Fiend monster battles an opponent's monster: You
-- can send 1 "Evil HERO" monster from your Deck or Extra Deck to the GY; your monster gains ATK equal
-- to the Level of the monster sent to the GY x 200, until the end of this turn (even if this card
-- leaves the field).
--[[ __CARD_HEADER_END__ ]]

--覇王城
function c72043279.initial_effect(c)
	aux.AddCodeList(c,94820406)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--fusion
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_FZONE)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetCode(72043279)
	e2:SetTargetRange(1,0)
	c:RegisterEffect(e2)
	--atk
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(72043279,0))
	e3:SetCategory(CATEGORY_ATKCHANGE)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetRange(LOCATION_FZONE)
	e3:SetCode(EVENT_PRE_DAMAGE_CALCULATE)
	e3:SetCountLimit(1)
	e3:SetCondition(c72043279.atkcon)
	e3:SetCost(c72043279.atkcost)
	e3:SetOperation(c72043279.atkop)
	c:RegisterEffect(e3)
end
function c72043279.atkcon(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetAttacker()
	local bc=Duel.GetAttackTarget()
	if not bc then return false end
	if tc:IsControler(1-tp) then tc=bc end
	e:SetLabelObject(tc)
	return tc:IsFaceup() and tc:IsRace(RACE_FIEND)
end
function c72043279.atkfilter(c)
	return c:IsType(TYPE_MONSTER) and c:IsSetCard(0x6008) and c:IsLevelAbove(0) and c:IsAbleToGraveAsCost()
end
function c72043279.atkcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c72043279.atkfilter,tp,LOCATION_DECK+LOCATION_EXTRA,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c72043279.atkfilter,tp,LOCATION_DECK+LOCATION_EXTRA,0,1,1,nil)
	Duel.SendtoGrave(g,REASON_COST)
	e:SetLabel(g:GetFirst():GetLevel())
end
function c72043279.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=e:GetLabelObject()
	if tc:IsRelateToBattle() and tc:IsFaceup() and tc:IsControler(tp) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(e:GetLabel()*200)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
	end
end
