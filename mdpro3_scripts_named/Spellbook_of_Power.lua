--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 水卜之魔导书  (ID: 25123082)
-- Type: Spell
-- ATK 0 | DEF 0
-- Setcode: 4206
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张。
-- ①：以自己场上1只魔法师族怪兽为对象才能发动。这个回合，那只怪兽的攻击力上升1000，以下效果适用。
-- ●那只怪兽战斗破坏对方怪兽时才能发动。从卡组把1张「魔导书」魔法卡加入手卡。
--[[ __CARD_HEADER_END__ ]]

--ヒュグロの魔導書
function c25123082.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,25123082+EFFECT_COUNT_CODE_OATH)
	e1:SetTarget(c25123082.target)
	e1:SetOperation(c25123082.activate)
	c:RegisterEffect(e1)
end
function c25123082.filter(c)
	return c:IsFaceup() and c:IsRace(RACE_SPELLCASTER)
end
function c25123082.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c25123082.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c25123082.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c25123082.filter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c25123082.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() and not tc:IsImmuneToEffect(e) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		e1:SetValue(1000)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetDescription(aux.Stringid(25123082,0))
		e2:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
		e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
		e2:SetCode(EVENT_BATTLE_DESTROYING)
		e2:SetLabelObject(tc)
		e2:SetCondition(c25123082.shcon)
		e2:SetTarget(c25123082.shtg)
		e2:SetOperation(c25123082.shop)
		e2:SetReset(RESET_PHASE+PHASE_END)
		Duel.RegisterEffect(e2,tp)
		local e3=Effect.CreateEffect(e:GetHandler())
		e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e3:SetCode(EFFECT_DESTROY_REPLACE)
		e3:SetRange(LOCATION_MZONE)
		e3:SetCondition(c25123082.regcon)
		e3:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e3)
	end
end
function c25123082.regcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:GetBattleTarget() and r==REASON_BATTLE then
		c:RegisterFlagEffect(25123082,RESET_PHASE+PHASE_DAMAGE,0,1)
	end
	return false
end
function c25123082.shcon(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	return eg:IsContains(tc) and tc:GetFlagEffect(25123082)~=0
end
function c25123082.shfilter(c)
	return c:IsSetCard(0x106e) and c:IsType(TYPE_SPELL) and c:IsAbleToHand()
end
function c25123082.shtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c25123082.shfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c25123082.shop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c25123082.shfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
