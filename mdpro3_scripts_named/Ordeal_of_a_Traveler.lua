--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 旅人的试练  (ID: 39537362)
-- Type: Trap / Equip
-- ATK 0 | DEF 0
--
-- Effect Text:
-- ①：对方怪兽的攻击宣言时1次，可以把这个效果发动。自己1张手卡由对方随机选，对方对那张卡的种类（怪兽·魔法·陷阱）作猜测。猜错的场合，那只攻击怪兽回到持有者手卡。
--[[ __CARD_HEADER_END__ ]]

--旅人の試練
function c39537362.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--tohand
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(39537362,0))
	e2:SetCategory(CATEGORY_TOHAND)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_ATTACK_ANNOUNCE)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1,EFFECT_COUNT_CODE_CHAIN)
	e2:SetCondition(c39537362.condition)
	e2:SetTarget(c39537362.target)
	e2:SetOperation(c39537362.activate)
	c:RegisterEffect(e2)
end
function c39537362.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttacker():IsControler(1-tp)
end
function c39537362.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)>0 end
	Duel.SetTargetCard(Duel.GetAttacker())
end
function c39537362.activate(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFieldGroupCount(tp,LOCATION_HAND,0)==0
		or not Duel.GetAttacker():IsRelateToEffect(e) then return end
	local g=Duel.GetFieldGroup(tp,LOCATION_HAND,0):RandomSelect(1-tp,1)
	local tc=g:GetFirst()
	Duel.Hint(HINT_SELECTMSG,1-tp,HINTMSG_CARDTYPE)
	local op=Duel.AnnounceType(1-tp)
	Duel.ConfirmCards(1-tp,tc)
	Duel.ShuffleHand(tp)
	if (op~=0 and tc:IsType(TYPE_MONSTER)) or (op~=1 and tc:IsType(TYPE_SPELL)) or (op~=2 and tc:IsType(TYPE_TRAP)) then
		Duel.SendtoHand(Duel.GetAttacker(),nil,REASON_EFFECT)
	end
end
