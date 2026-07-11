--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:52
-- Source DB: cards.cdb
-- Card: Protecting Spirit Loagaeth  (ID: 84339249)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Fairy
-- Level: 7
-- ATK 2400 | DEF 2100
-- Scope: OCG / TCG
--
-- Effect Text:
-- If this card on the field is destroyed by battle or card effect: You can target 1 monster on the
-- field; it cannot be destroyed by battle this turn.
-- You can only use each of the following effects of "Protecting Spirit Loagaeth" once per turn.
-- If an effect of a Fairy monster you control is activated (except during the Damage Step): You can
-- Special Summon this card from your hand.
-- You can target 1 face-up card your opponent controls and 1 Attack Position monster you control;
-- banish that opponent's card, and if you do, change your monster to Defense Position.
--[[ __CARD_HEADER_END__ ]]

--守護天霊ロガエス
function c84339249.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(84339249,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_CUSTOM+84339249)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,84339249)
	e1:SetCondition(c84339249.spcon)
	e1:SetTarget(c84339249.sptg)
	e1:SetOperation(c84339249.spop)
	c:RegisterEffect(e1)
	--remove
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(84339249,1))
	e2:SetCategory(CATEGORY_REMOVE+CATEGORY_POSITION)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,84339250)
	e2:SetTarget(c84339249.rmtg)
	e2:SetOperation(c84339249.rmop)
	c:RegisterEffect(e2)
	--indes
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(84339249,2))
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_DESTROYED)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DELAY)
	e3:SetCondition(c84339249.indcon)
	e3:SetTarget(c84339249.indtg)
	e3:SetOperation(c84339249.indop)
	c:RegisterEffect(e3)
	if not c84339249.global_check then
		c84339249.global_check=true
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
		ge1:SetCode(EVENT_CHAIN_SOLVED)
		ge1:SetCondition(c84339249.regcon)
		ge1:SetOperation(c84339249.regop)
		Duel.RegisterEffect(ge1,0)
	end
end
function c84339249.regcon(e,tp,eg,ep,ev,re,r,rp)
	local loc,race=Duel.GetChainInfo(ev,CHAININFO_TRIGGERING_LOCATION,CHAININFO_TRIGGERING_RACE)
	return re:IsActiveType(TYPE_MONSTER) and loc&LOCATION_MZONE~=0 and race&RACE_FAIRY~=0
end
function c84339249.regop(e,tp,eg,ep,ev,re,r,rp)
	Duel.RaiseEvent(re:GetHandler(),EVENT_CUSTOM+84339249,re,r,rp,ep,ev)
end
function c84339249.spcon(e,tp,eg,ep,ev,re,r,rp)
	return rp==tp
end
function c84339249.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c84339249.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
	end
end
function c84339249.rmfilter(c)
	return c:IsFaceup() and c:IsAbleToRemove()
end
function c84339249.posfilter(c)
	return c:IsAttackPos() and c:IsCanChangePosition()
end
function c84339249.rmtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return Duel.IsExistingTarget(c84339249.rmfilter,tp,0,LOCATION_ONFIELD,1,nil)
		and Duel.IsExistingTarget(c84339249.posfilter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g1=Duel.SelectTarget(tp,c84339249.rmfilter,tp,0,LOCATION_ONFIELD,1,1,nil)
	e:SetLabelObject(g1:GetFirst())
	local g2=Duel.SelectTarget(tp,c84339249.posfilter,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g1,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_POSITION,g2,1,0,0)
end
function c84339249.rmop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=e:GetLabelObject()
	local tg=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local lc=tg:GetFirst()
	if lc==tc then lc=tg:GetNext() end
	if tc:IsRelateToEffect(e) and tc:IsControler(1-tp)
		and Duel.Remove(tc,POS_FACEUP,REASON_EFFECT)~=0 and tc:IsLocation(LOCATION_REMOVED)
		and lc:IsRelateToEffect(e) and lc:IsControler(tp) then
		Duel.ChangePosition(lc,POS_FACEUP_DEFENSE,POS_FACEDOWN_DEFENSE,POS_FACEUP_DEFENSE,POS_FACEDOWN_DEFENSE)
	end
end
function c84339249.indcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsPreviousLocation(LOCATION_ONFIELD) and c:IsReason(REASON_BATTLE+REASON_EFFECT)
end
function c84339249.indtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) end
	if chk==0 then return Duel.IsExistingTarget(nil,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,nil,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
end
function c84339249.indop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		e1:SetValue(1)
		tc:RegisterEffect(e1)
	end
end
