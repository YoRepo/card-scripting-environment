--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:24
-- Card: 龙骑兵团骑士-雷枪龙骑士  (ID: 21249921)
-- Type: Monster / Effect / Synchro
-- Attribute: WIND
-- Race: Dragon
-- Level 6
-- ATK 1900 | DEF 1200
-- Setcode: 41
--
-- Effect Text:
-- 龙族调整＋调整以外的鸟兽族怪兽1只以上
-- ①：这张卡同调召唤时，以自己墓地1只3星以下的龙族「龙骑兵团」怪兽为对象才能发动。那只龙族怪兽当作装备魔法卡使用给这张卡装备。
-- ②：1回合1次，把这张卡装备的自己场上1张装备卡送去墓地才能发动。这张卡的攻击力直到回合结束时变成2倍。
--[[ __CARD_HEADER_END__ ]]

--ドラグニティナイト－ヴァジュランダ
function c21249921.initial_effect(c)
	--synchro summon
	aux.AddSynchroProcedure(c,aux.FilterBoolFunction(Card.IsRace,RACE_DRAGON),aux.NonTuner(Card.IsRace,RACE_WINDBEAST),1)
	c:EnableReviveLimit()
	--equip
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(21249921,0))
	e1:SetCategory(CATEGORY_LEAVE_GRAVE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCondition(c21249921.eqcon)
	e1:SetTarget(c21249921.eqtg)
	e1:SetOperation(c21249921.eqop)
	c:RegisterEffect(e1)
	--atk
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(21249921,1))
	e2:SetCategory(CATEGORY_ATKCHANGE)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetCountLimit(1)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCost(c21249921.atkcost)
	e2:SetOperation(c21249921.atkop)
	c:RegisterEffect(e2)
end
function c21249921.eqcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_SYNCHRO)
end
function c21249921.filter(c)
	return c:IsLevelBelow(3) and c:IsSetCard(0x29) and c:IsRace(RACE_DRAGON) and not c:IsForbidden()
end
function c21249921.eqtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c21249921.filter(chkc) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>0
		and Duel.IsExistingTarget(c21249921.filter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	local g=Duel.SelectTarget(tp,c21249921.filter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_LEAVE_GRAVE,g,1,0,0)
end
function c21249921.eqop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsRace(RACE_DRAGON) then
		if not Duel.Equip(tp,tc,c,false) then return end
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_OWNER_RELATE)
		e1:SetCode(EFFECT_EQUIP_LIMIT)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		e1:SetValue(c21249921.eqlimit)
		tc:RegisterEffect(e1)
	end
end
function c21249921.eqlimit(e,c)
	return e:GetOwner()==c
end
function c21249921.atkfilter(c,tp)
	return c:IsControler(tp) and c:IsAbleToGraveAsCost()
end
function c21249921.atkcost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:GetEquipGroup():IsExists(c21249921.atkfilter,1,nil,e:GetHandlerPlayer()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=c:GetEquipGroup():FilterSelect(tp,c21249921.atkfilter,1,1,nil,e:GetHandlerPlayer())
	Duel.SendtoGrave(g,REASON_COST)
end
function c21249921.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFaceup() and c:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetValue(c:GetAttack()*2)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e1)
	end
end
