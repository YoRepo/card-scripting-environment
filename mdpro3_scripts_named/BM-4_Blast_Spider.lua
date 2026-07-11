--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:45
-- Source DB: cards.cdb
-- Card: BM-4 Blast Spider  (ID: 40634253)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Machine
-- Level: 4
-- ATK 1400 | DEF 2200
-- Scope: OCG / TCG
--
-- Effect Text:
-- Once per turn: You can target 1 DARK Machine monster you control and 1 face-up card your opponent
-- controls; destroy them.
-- If a monster you control that was originally a DARK Machine destroys an opponent's monster(s) by
-- battle or card effect and sends it to the GY: You can inflict damage to your opponent equal to half
-- the original ATK of 1 of those monster(s) destroyed and sent to the GY.
-- You can only use this effect of "BM-4 Blast Spider" once per turn.
--[[ __CARD_HEADER_END__ ]]

--BM－4ボムスパイダー
function c40634253.initial_effect(c)
	--Destroy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(40634253,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetTarget(c40634253.destg)
	e1:SetOperation(c40634253.desop)
	c:RegisterEffect(e1)
	--damage
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(40634253,1))
	e2:SetCategory(CATEGORY_DAMAGE)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_DAMAGE_STEP)
	e2:SetCode(EVENT_BATTLE_DESTROYED)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,40634253)
	e2:SetCondition(c40634253.damcon1)
	e2:SetTarget(c40634253.damtg)
	e2:SetOperation(c40634253.damop1)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EVENT_TO_GRAVE)
	e3:SetCondition(c40634253.damcon2)
	e3:SetOperation(c40634253.damop2)
	c:RegisterEffect(e3)
end
function c40634253.desfilter(c)
	return c:IsFaceup() and c:IsRace(RACE_MACHINE) and c:IsAttribute(ATTRIBUTE_DARK)
end
function c40634253.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return false end
	if chk==0 then return Duel.IsExistingTarget(c40634253.desfilter,tp,LOCATION_MZONE,0,1,nil)
		and Duel.IsExistingTarget(Card.IsFaceup,tp,0,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g1=Duel.SelectTarget(tp,c40634253.desfilter,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g2=Duel.SelectTarget(tp,Card.IsFaceup,tp,0,LOCATION_ONFIELD,1,1,nil)
	g1:Merge(g2)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g1,2,0,0)
end
function c40634253.desop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	local tg=g:Filter(Card.IsRelateToEffect,nil,e)
	if tg:GetCount()>0 then
		Duel.Destroy(tg,REASON_EFFECT)
	end
end
function c40634253.damcon1(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	local bc=tc:GetBattleTarget()
	return tc:IsPreviousControler(1-tp) and tc:IsLocation(LOCATION_GRAVE) and tc:GetTextAttack()>0
		and bc:IsControler(tp) and bc:GetOriginalAttribute()==ATTRIBUTE_DARK and bc:GetOriginalRace()==RACE_MACHINE and bc:IsType(TYPE_MONSTER)
end
function c40634253.damfilter2(c,tp)
	return c:IsReason(REASON_EFFECT) and c:IsType(TYPE_MONSTER) and c:IsReason(REASON_DESTROY) and c:IsLocation(LOCATION_GRAVE)
		and c:IsPreviousControler(1-tp) and c:GetTextAttack()>0
end
function c40634253.damcon2(e,tp,eg,ep,ev,re,r,rp)
	if not re then return false end
	local tgp,loc=Duel.GetChainInfo(ev,CHAININFO_TRIGGERING_CONTROLER,CHAININFO_TRIGGERING_LOCATION)
	local rc=re:GetHandler()
	return tgp==tp and loc==LOCATION_MZONE
		and rc:GetOriginalAttribute()==ATTRIBUTE_DARK and rc:GetOriginalRace()==RACE_MACHINE
		and eg:IsExists(c40634253.damfilter2,1,nil,tp)
end
function c40634253.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,0)
end
function c40634253.damop1(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	Duel.Damage(1-tp,math.floor(tc:GetTextAttack()/2),REASON_EFFECT)
end
function c40634253.damop2(e,tp,eg,ep,ev,re,r,rp)
	local g=eg:Filter(c40634253.damfilter2,nil,tp)
	local tc=nil
	if #g>1 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
		tc=g:Select(tp,1,1,nil):GetFirst()
	elseif #g==1 then
		tc=g:GetFirst()
	end
	if tc then
		Duel.Damage(1-tp,math.floor(tc:GetTextAttack()/2),REASON_EFFECT)
	end
end
