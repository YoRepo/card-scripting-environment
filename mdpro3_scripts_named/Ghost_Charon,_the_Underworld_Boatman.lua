--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:43
-- Source DB: cards.cdb
-- Card: Ghost Charon, the Underworld Boatman  (ID: 23379054)
-- Type: Monster / Effect / Tuner
-- Attribute: DARK
-- Race: Zombie
-- Level: 2
-- ATK 500 | DEF 0
-- Scope: OCG / TCG
--
-- Effect Text:
-- If your opponent controls a monster, and you control no other monsters: You can target 1 Fusion
-- Monster in your Graveyard; banish both this card from the field and that target, and if you do,
-- Special Summon 1 Dragon-Type Synchro Monster from your Extra Deck whose Level equals the total
-- Levels those 2 monsters had (original Level, if face-down).
-- You can only use this effect of "Ghost Charon, the Underworld Boatman" once per turn.
-- You cannot Special Summon monsters the turn you activate this effect, except Dragon-Type monsters.
--[[ __CARD_HEADER_END__ ]]

--劫火の舟守 ゴースト・カロン
function c23379054.initial_effect(c)
	--spsummon
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,23379054)
	e1:SetCondition(c23379054.condition)
	e1:SetCost(c23379054.cost)
	e1:SetTarget(c23379054.target)
	e1:SetOperation(c23379054.operation)
	c:RegisterEffect(e1)
	Duel.AddCustomActivityCounter(23379054,ACTIVITY_SPSUMMON,c23379054.counterfilter)
end
function c23379054.counterfilter(c)
	return c:IsRace(RACE_DRAGON) and c:IsFaceup()
end
function c23379054.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFieldGroupCount(tp,0,LOCATION_MZONE)>0
		and Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)==1
end
function c23379054.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetCustomActivityCount(23379054,tp,ACTIVITY_SPSUMMON)==0 end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_OATH)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetReset(RESET_PHASE+PHASE_END)
	e1:SetTargetRange(1,0)
	e1:SetTarget(c23379054.splimit)
	Duel.RegisterEffect(e1,tp)
end
function c23379054.splimit(e,c,sump,sumtype,sumpos,targetp,se)
	return c:GetRace()~=RACE_DRAGON
end
function c23379054.filter1(c,e,tp,lv,mc)
	return c:IsType(TYPE_FUSION) and c:IsAbleToRemove()
		and Duel.IsExistingMatchingCard(c23379054.filter2,tp,LOCATION_EXTRA,0,1,nil,e,tp,lv+c:GetLevel(),mc)
end
function c23379054.filter2(c,e,tp,lv,mc)
	return c:IsLevel(lv) and c:IsRace(RACE_DRAGON) and c:IsType(TYPE_SYNCHRO)
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false) and Duel.GetLocationCountFromEx(tp,tp,mc,c)>0
end
function c23379054.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local c=e:GetHandler()
	if chkc then return chkc:IsControler(tp) and chkc:IsLocation(LOCATION_GRAVE) and c23379054.filter1(chkc,e,tp,c:GetLevel(),c) end
	if chk==0 then return c:IsAbleToRemove()
		and Duel.IsExistingTarget(c23379054.filter1,tp,LOCATION_GRAVE,0,1,nil,e,tp,c:GetLevel(),c) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectTarget(tp,c23379054.filter1,tp,LOCATION_GRAVE,0,1,1,nil,e,tp,c:GetLevel(),c)
	g:AddCard(e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,g,2,tp,LOCATION_GRAVE)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c23379054.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if not c:IsRelateToEffect(e) or not tc:IsRelateToEffect(e) then return end
	local lv=c:GetLevel()+tc:GetLevel()
	local g=Group.FromCards(c,tc)
	if Duel.Remove(g,POS_FACEUP,REASON_EFFECT)==2 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local sg=Duel.SelectMatchingCard(tp,c23379054.filter2,tp,LOCATION_EXTRA,0,1,1,nil,e,tp,lv,nil)
		if sg:GetCount()>0 then
			Duel.SpecialSummon(sg,0,tp,tp,false,false,POS_FACEUP)
		end
	end
end
