--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:45
-- Source DB: cards.cdb
-- Card: Prohibit Snake  (ID: 39732186)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Cyberse
-- Level: 2
-- ATK 500 | DEF 1000
-- Scope: OCG / TCG
--
-- Effect Text:
-- At the start of the Damage Step, if your Cyberse Link Monster battles an opponent's monster: You can
-- send this card from your hand to the GY; return that opponent's monster to the hand.
-- When your Cyberse monster destroys an opponent's monster by battle and sends it to the GY, while
-- this card is in your GY: You can banish 1 card from your GY, then target 1 Level 4 or lower Cyberse
-- monster in your GY; add it to your hand.
-- You can only use each effect of "Prohibit Snake" once per turn.
--[[ __CARD_HEADER_END__ ]]

--プロフィビット・スネーク
function c39732186.initial_effect(c)
	--opp to hand
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(39732186,0))
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_BATTLE_START)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,39732186)
	e1:SetCondition(c39732186.thcon)
	e1:SetCost(c39732186.thcost)
	e1:SetTarget(c39732186.thtg)
	e1:SetOperation(c39732186.thop)
	c:RegisterEffect(e1)
	--GY to hand
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(39732186,1))
	e2:SetCategory(CATEGORY_TOHAND)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_BATTLE_DESTROYED)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCountLimit(1,39732187)
	e2:SetCondition(c39732186.thcon2)
	e2:SetCost(c39732186.thcost2)
	e2:SetTarget(c39732186.thtg2)
	e2:SetOperation(c39732186.thop2)
	c:RegisterEffect(e2)
end
function c39732186.thcon(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetAttacker()
	local bc=Duel.GetAttackTarget()
	if not bc then return false end
	if tc:IsControler(1-tp) then tc,bc=bc,tc end
	e:SetLabelObject(bc)
	return tc:IsFaceup() and tc:IsRace(RACE_CYBERSE) and tc:IsType(TYPE_LINK)
end
function c39732186.thcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToGraveAsCost() end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST)
end
function c39732186.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	local bc=e:GetLabelObject()
	if chk==0 then return bc and bc:IsAbleToHand() end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,bc,1,0,0)
end
function c39732186.thop(e,tp,eg,ep,ev,re,r,rp)
	local bc=e:GetLabelObject()
	if bc:IsRelateToBattle() and bc:IsControler(1-tp) then
		Duel.SendtoHand(bc,nil,REASON_EFFECT)
	end
end
function c39732186.thcon2(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	local bc=tc:GetBattleTarget()
	return eg:GetCount()==1	and tc:IsLocation(LOCATION_GRAVE) and tc:IsReason(REASON_BATTLE)
		and bc:IsRelateToBattle() and bc:IsControler(tp) and bc:IsRace(RACE_CYBERSE)
end
function c39732186.cfilter(c,tp)
	return c:IsAbleToRemoveAsCost() and Duel.IsExistingTarget(c39732186.thfilter,tp,LOCATION_GRAVE,0,1,c)
end
function c39732186.thfilter(c)
	return c:IsLevelBelow(4) and c:IsRace(RACE_CYBERSE) and c:IsAbleToHand()
end
function c39732186.thcost2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c39732186.cfilter,tp,LOCATION_GRAVE,0,1,nil,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c39732186.cfilter,tp,LOCATION_GRAVE,0,1,1,nil,tp)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c39732186.thtg2(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c39732186.thfilter(chkc) end
	if chk==0 then return true end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectTarget(tp,c39732186.thfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
end
function c39732186.thop2(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
	end
end
