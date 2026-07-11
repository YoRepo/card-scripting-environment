--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:51
-- Source DB: cards.cdb
-- Card: Scanner  (ID: 75198893)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Machine
-- Level: 1
-- ATK ? | DEF ?
-- Scope: OCG / TCG
--
-- Effect Text:
-- Once per turn, you can select 1 of your opponent's monsters that is removed from play.
-- Until the End Phase, this card's name is treated as the selected monster's name, and this card has
-- the same Attribute, Level, ATK, and DEF as the selected monster.
-- If this card is removed from the field while this effect is applied, remove it from play.
--[[ __CARD_HEADER_END__ ]]

--スキヤナー
function c75198893.initial_effect(c)
	--copy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(75198893,0))
	e1:SetCategory(CATEGORY_REMOVE)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCountLimit(1)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTarget(c75198893.target)
	e1:SetOperation(c75198893.operation)
	c:RegisterEffect(e1)
end
function c75198893.filter(c)
	return c:IsFaceup() and c:IsType(TYPE_MONSTER) and c:IsLevelAbove(0) and not c:IsForbidden()
end
function c75198893.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_REMOVED) and chkc:IsControler(1-tp) and c75198893.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c75198893.filter,tp,0,LOCATION_REMOVED,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c75198893.filter,tp,0,LOCATION_REMOVED,1,1,nil)
end
function c75198893.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and c:IsFaceup() and tc:IsRelateToEffect(e) then
		local code=tc:GetOriginalCode()
		local ba=tc:GetBaseAttack()
		local bd=tc:GetBaseDefense()
		local at=tc:GetAttribute()
		local lv=tc:GetLevel()
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetCode(EFFECT_CHANGE_CODE)
		e1:SetValue(code)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e1)
		local e2=e1:Clone()
		e2:SetCode(EFFECT_SET_ATTACK_FINAL)
		e2:SetValue(ba)
		c:RegisterEffect(e2)
		local e3=e1:Clone()
		e3:SetCode(EFFECT_SET_DEFENSE_FINAL)
		e3:SetValue(bd)
		c:RegisterEffect(e3)
		local e4=e1:Clone()
		e4:SetCode(EFFECT_CHANGE_ATTRIBUTE)
		e4:SetValue(at)
		c:RegisterEffect(e4)
		local e5=e1:Clone()
		e5:SetCode(EFFECT_CHANGE_LEVEL)
		e5:SetValue(lv)
		c:RegisterEffect(e5)
		--leave redir
		local e6=Effect.CreateEffect(c)
		e6:SetType(EFFECT_TYPE_SINGLE)
		e6:SetCode(EFFECT_LEAVE_FIELD_REDIRECT)
		e6:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e6:SetReset(RESET_EVENT+RESETS_REDIRECT+RESET_PHASE+PHASE_END)
		e6:SetValue(LOCATION_REMOVED)
		c:RegisterEffect(e6)
	end
end
