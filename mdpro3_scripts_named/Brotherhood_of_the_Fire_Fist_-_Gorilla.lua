--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 勇炎星-猿胜  (ID: 70355994)
-- Type: Monster / Effect
-- Attribute: FIRE
-- Race: Beast-Warrior
-- Level 4
-- ATK 1600 | DEF 1000
-- Setcode: 121
--
-- Effect Text:
-- 1回合1次，这张卡战斗破坏对方怪兽送去墓地时，可以从卡组选1张名字带有「炎舞」的魔法卡在自己场上盖放。此外，1回合1次，把自己场上表侧表示存在的1张名字带有「炎舞」的魔法·陷阱卡送去墓地才能发动。选择
-- 场上1张魔法·陷阱卡破坏。
--[[ __CARD_HEADER_END__ ]]

--勇炎星－エンショウ
function c70355994.initial_effect(c)
	--set
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(70355994,0))
	e1:SetCategory(CATEGORY_SSET)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_BATTLE_DESTROYING)
	e1:SetCountLimit(1)
	e1:SetCondition(c70355994.setcon)
	e1:SetTarget(c70355994.settg)
	e1:SetOperation(c70355994.setop)
	c:RegisterEffect(e1)
	--destroy
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(70355994,1))
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCategory(CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetCost(c70355994.descost)
	e2:SetTarget(c70355994.destg)
	e2:SetOperation(c70355994.desop)
	c:RegisterEffect(e2)
end
function c70355994.setcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	return c:IsRelateToBattle() and bc:IsLocation(LOCATION_GRAVE) and bc:IsReason(REASON_BATTLE)
end
function c70355994.filter(c)
	return c:IsSetCard(0x7c) and c:IsType(TYPE_SPELL) and c:IsSSetable()
end
function c70355994.settg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c70355994.filter,tp,LOCATION_DECK,0,1,nil) end
end
function c70355994.setop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SET)
	local g=Duel.SelectMatchingCard(tp,c70355994.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SSet(tp,g:GetFirst())
	end
end
function c70355994.filter1(c)
	return c:IsFaceup() and c:IsSetCard(0x7c) and c:IsType(TYPE_SPELL+TYPE_TRAP) and c:IsAbleToGraveAsCost()
		and Duel.IsExistingTarget(c70355994.filter2,0,LOCATION_ONFIELD,LOCATION_ONFIELD,1,c)
end
function c70355994.descost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c70355994.filter1,tp,LOCATION_ONFIELD,0,1,nil)
		or (Duel.IsPlayerAffectedByEffect(tp,46241344) and Duel.IsExistingTarget(c70355994.filter2,0,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil)) end
	if Duel.IsExistingMatchingCard(c70355994.filter1,tp,LOCATION_ONFIELD,0,1,nil)
		and (not Duel.IsPlayerAffectedByEffect(tp,46241344) or not Duel.SelectYesNo(tp,aux.Stringid(46241344,0))) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
		local g=Duel.SelectMatchingCard(tp,c70355994.filter1,tp,LOCATION_ONFIELD,0,1,1,nil)
		Duel.SendtoGrave(g,REASON_COST)
	end
end
function c70355994.filter2(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP)
end
function c70355994.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and c70355994.filter2(chkc) end
	if chk==0 then return true end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g2=Duel.SelectTarget(tp,c70355994.filter2,tp,LOCATION_ONFIELD,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g2,1,0,0)
end
function c70355994.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
