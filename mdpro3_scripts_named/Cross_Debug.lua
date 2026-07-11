--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: Cross Debug  (ID: 9097866)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Cyberse
-- Level: 2
-- ATK 900 | DEF 600
-- Scope: OCG / TCG
--
-- Effect Text:
-- If you control 2 or more Link Monsters: You can Special Summon this card from your hand.
-- During damage calculation, if your Link Monster battles an opponent's Link Monster (Quick Effect):
-- You can banish this card from your GY, then target 1 Link Monster in your GY; your battling monster
-- cannot be destroyed by that battle, also, until the end of this turn, it gains ATK equal to the
-- target's ATK.
-- You can only use each effect of "Cross Debug" once per turn.
--[[ __CARD_HEADER_END__ ]]

--クロス・デバッガー
function c9097866.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(9097866,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,9097866)
	e1:SetCondition(c9097866.spcon)
	e1:SetTarget(c9097866.sptg)
	e1:SetOperation(c9097866.spop)
	c:RegisterEffect(e1)
	--atk up
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(9097866,0))
	e2:SetCategory(CATEGORY_ATKCHANGE)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_PRE_DAMAGE_CALCULATE)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCountLimit(1,9097867)
	e2:SetCondition(c9097866.atkcon)
	e2:SetCost(aux.bfgcost)
	e2:SetTarget(c9097866.atktg)
	e2:SetOperation(c9097866.atkop)
	c:RegisterEffect(e2)
end
function c9097866.cfilter(c)
	return c:IsFaceup() and c:IsType(TYPE_LINK)
end
function c9097866.spcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c9097866.cfilter,tp,LOCATION_MZONE,0,2,nil)
end
function c9097866.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c9097866.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
end
function c9097866.atkcon(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	if a:IsControler(1-tp) then a,d=d,a end
	e:SetLabelObject(a)
	return a and d and a:IsRelateToBattle() and d:IsRelateToBattle() and a:IsType(TYPE_LINK) and d:IsType(TYPE_LINK)
end
function c9097866.atkfilter(c)
	return c:IsType(TYPE_LINK) and c:IsAttackAbove(0)
end
function c9097866.atktg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c9097866.atkfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c9097866.atkfilter,tp,LOCATION_GRAVE,0,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c9097866.atkfilter,tp,LOCATION_GRAVE,0,1,1,nil)
end
function c9097866.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local a=e:GetLabelObject()
	local tc=Duel.GetFirstTarget()
	if a:IsFaceup() and a:IsRelateToBattle() and tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(tc:GetAttack())
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		a:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
		e2:SetValue(1)
		e2:SetReset(RESET_PHASE+PHASE_DAMAGE)
		a:RegisterEffect(e2)
	end
end
