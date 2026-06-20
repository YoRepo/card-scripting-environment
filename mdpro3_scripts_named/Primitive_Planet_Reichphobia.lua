--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:30
-- Card: 肆世坏-恐惧世界  (ID: 56063182)
-- Type: Spell / Counter
-- ATK 0 | DEF 0
--
-- Effect Text:
-- 这个卡名的卡在1回合只能发动1张，这个卡名的③的效果1回合只能使用1次。
-- ①：作为这张卡的发动时的效果处理，可以从卡组把1只「恐吓爪牙族」怪兽或者「维萨斯-斯塔弗罗斯特」加入手卡。
-- ②：对方场上的怪兽的攻击力·守备力下降场上的守备表示怪兽数量×100。
-- ③：场上有守备表示怪兽3只以上存在的场合，以对方场上1张卡为对象才能发动。那张卡破坏。
--[[ __CARD_HEADER_END__ ]]

--肆世壊＝ライフォビア
local s,id,o=GetID()
function c56063182.initial_effect(c)
	aux.AddCodeList(c,56099748)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,56063182+EFFECT_COUNT_CODE_OATH)
	e1:SetOperation(c56063182.activate)
	c:RegisterEffect(e1)
	--Decrease Atk
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_ATKCHANGE)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetRange(LOCATION_FZONE)
	e2:SetTargetRange(0,LOCATION_MZONE)
	e2:SetValue(c56063182.atkval)
	c:RegisterEffect(e2)
	--Decrease Atk
	local e3=e2:Clone()
	e3:SetCode(EFFECT_UPDATE_DEFENSE)
	c:RegisterEffect(e3)
	--destroy1
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(56063182,1))
	e4:SetCategory(CATEGORY_DESTROY)
	e4:SetType(EFFECT_TYPE_IGNITION)
	e4:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e4:SetRange(LOCATION_FZONE)
	e4:SetCountLimit(1,56063182+o)
	e4:SetCondition(c56063182.descon)
	e4:SetTarget(c56063182.destg)
	e4:SetOperation(c56063182.desop)
	c:RegisterEffect(e4)
end
function c56063182.filter(c)
	return ((c:IsSetCard(0x17a) and c:IsType(TYPE_MONSTER)) or c:IsCode(56099748)) and c:IsAbleToHand()
end
function c56063182.activate(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c56063182.filter,tp,LOCATION_DECK,0,nil)
	if g:GetCount()>0 and Duel.SelectYesNo(tp,aux.Stringid(56063182,0)) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local sg=g:Select(tp,1,1,nil)
		Duel.SendtoHand(sg,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,sg)
	end
end
function c56063182.atkval(e)
	return Duel.GetMatchingGroupCount(Card.IsDefensePos,e:GetHandlerPlayer(),LOCATION_MZONE,LOCATION_MZONE,nil)*-100
end
function c56063182.descon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetMatchingGroupCount(Card.IsDefensePos,tp,LOCATION_MZONE,LOCATION_MZONE,nil)>=3
end
function c56063182.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and chkc:IsControler(1-tp) end
	if chk==0 then return Duel.IsExistingTarget(aux.TRUE,tp,0,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,aux.TRUE,tp,0,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
end
function c56063182.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
