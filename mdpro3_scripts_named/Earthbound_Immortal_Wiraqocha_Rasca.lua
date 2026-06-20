--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 地缚神 维拉科查·拉斯卡  (ID: 41181774)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Winged Beast
-- Level 10
-- ATK 100 | DEF 100
-- Setcode: 4129
--
-- Effect Text:
-- ①：「地缚神」怪兽在场上只能有1只表侧表示存在。
-- ②：这张卡召唤成功的场合，以最多有对方手卡数量的这张卡以外的自己场上的卡为对象发动（最多3张）。那些卡回到持有者卡组。那之后，对方手卡随机选回去的数量丢弃，这张卡的攻击力上升丢弃数量×1000。
-- ③：这张卡可以直接攻击。
-- ④：对方不能选择这张卡作为攻击对象。
-- ⑤：没有场地魔法卡表侧表示存在的场合这张卡破坏。
--[[ __CARD_HEADER_END__ ]]

--地縛神 Wiraqocha Rasca
function c41181774.initial_effect(c)
	c:SetUniqueOnField(1,1,aux.FilterBoolFunction(Card.IsSetCard,0x1021),LOCATION_MZONE)
	--
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e4:SetRange(LOCATION_MZONE)
	e4:SetCode(EFFECT_SELF_DESTROY)
	e4:SetCondition(c41181774.sdcon)
	c:RegisterEffect(e4)
	--battle target
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE)
	e5:SetCode(EFFECT_CANNOT_BE_BATTLE_TARGET)
	e5:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e5:SetRange(LOCATION_MZONE)
	e5:SetValue(aux.imval1)
	c:RegisterEffect(e5)
	--direct atk
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_SINGLE)
	e6:SetCode(EFFECT_DIRECT_ATTACK)
	c:RegisterEffect(e6)
	--handes
	local e7=Effect.CreateEffect(c)
	e7:SetDescription(aux.Stringid(41181774,0))
	e7:SetCategory(CATEGORY_TODECK+CATEGORY_HANDES)
	e7:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e7:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e7:SetCode(EVENT_SUMMON_SUCCESS)
	e7:SetTarget(c41181774.hdtg)
	e7:SetOperation(c41181774.hdop)
	c:RegisterEffect(e7)
end
function c41181774.sdcon(e)
	return not Duel.IsExistingMatchingCard(Card.IsFaceup,0,LOCATION_FZONE,LOCATION_FZONE,1,nil)
end
function c41181774.hdtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and chkc:IsControler(tp) and chkc:IsAbleToDeck() end
	if chk==0 then return true end
	local ct=Duel.GetFieldGroupCount(tp,0,LOCATION_HAND)
	if ct==0 then return end
	if ct>3 then ct=3 end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectTarget(tp,Card.IsAbleToDeck,tp,LOCATION_ONFIELD,0,1,ct,e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g,g:GetCount(),0,0)
end
function c41181774.hdop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetChainInfo(0,CHAININFO_TARGET_CARDS)
	if not g then return end
	local sg=g:Filter(Card.IsRelateToEffect,nil,e)
	Duel.SendtoDeck(sg,nil,SEQ_DECKSHUFFLE,REASON_EFFECT)
	local ct=sg:FilterCount(Card.IsLocation,nil,LOCATION_DECK+LOCATION_EXTRA)
	if ct==0 then return end
	Duel.BreakEffect()
	local dg=Duel.GetFieldGroup(tp,0,LOCATION_HAND):RandomSelect(tp,ct)
	local dt=Duel.SendtoGrave(dg,REASON_EFFECT+REASON_DISCARD)
	local c=e:GetHandler()
	if dt~=0 and c:IsRelateToEffect(e) and c:IsFaceup() then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
		e1:SetRange(LOCATION_MZONE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(dt*1000)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE)
		c:RegisterEffect(e1)
	end
end
