--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:50
-- Source DB: cards.cdb
-- Card: Saber Shark  (ID: 63193879)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Fish
-- Level: 4
-- ATK 1600 | DEF 1200
-- Setcode: 0xd, 0x1b8
-- Scope: OCG / TCG
--
-- Effect Text:
-- Cannot be used as a Synchro Material.
-- Twice per turn: You can target 1 Fish monster on the field, then activate 1 of these effects.
-- ● Increase its Level by 1.
-- ● Reduce its Level by 1.
-- You cannot Special Summon any monsters during the turn you activate this effect, except WATER
-- monsters.
--[[ __CARD_HEADER_END__ ]]

--セイバー・シャーク
function c63193879.initial_effect(c)
	--lv change
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(63193879,0))
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(2)
	e1:SetCost(c63193879.cost)
	e1:SetTarget(c63193879.target)
	e1:SetOperation(c63193879.operation)
	c:RegisterEffect(e1)
	--unsynchroable
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_CANNOT_BE_SYNCHRO_MATERIAL)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e2:SetValue(1)
	c:RegisterEffect(e2)
	Duel.AddCustomActivityCounter(63193879,ACTIVITY_SPSUMMON,c63193879.counterfilter)
end
function c63193879.counterfilter(c)
	return c:IsAttribute(ATTRIBUTE_WATER)
end
function c63193879.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetCustomActivityCount(63193879,tp,ACTIVITY_SPSUMMON)==0 end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_OATH)
	e1:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e1:SetReset(RESET_PHASE+PHASE_END)
	e1:SetTargetRange(1,0)
	e1:SetTarget(c63193879.splimit)
	Duel.RegisterEffect(e1,tp)
end
function c63193879.splimit(e,c)
	return c:GetAttribute()~=ATTRIBUTE_WATER
end
function c63193879.filter(c)
	return c:IsFaceup() and c:IsRace(RACE_FISH) and c:GetLevel()>0
end
function c63193879.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c63193879.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c63193879.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g=Duel.SelectTarget(tp,c63193879.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	local op=0
	if g:GetFirst():IsLevel(1) then op=Duel.SelectOption(tp,aux.Stringid(63193879,1))
	else op=Duel.SelectOption(tp,aux.Stringid(63193879,1),aux.Stringid(63193879,2)) end
	e:SetLabel(op)
end
function c63193879.operation(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsFaceup() and tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetCode(EFFECT_UPDATE_LEVEL)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		if e:GetLabel()==0 then
			e1:SetValue(1)
		else e1:SetValue(-1) end
		tc:RegisterEffect(e1)
	end
end
