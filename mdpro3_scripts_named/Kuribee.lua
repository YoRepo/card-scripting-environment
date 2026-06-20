--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:33
-- Card: 栗子团  (ID: 71036835)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Fiend
-- Level 1
-- ATK 300 | DEF 200
-- Setcode: 164
--
-- Effect Text:
-- 这个卡名在规则上也当作「栗子球」卡使用。这个卡名的①的效果1回合只能使用1次。
-- ①：这张卡或者自己的「栗子球」怪兽被战斗破坏时才能发动。从卡组把有「栗子球」的卡名记述的1张魔法·陷阱卡加入手卡。
-- ②：1回合1次，自己场上有其他的「栗子球」怪兽存在的场合，对方怪兽的攻击宣言时才能发动。这张卡以外的自己场上的全部怪兽的攻击力直到回合结束时变成0，那次攻击无效。
--[[ __CARD_HEADER_END__ ]]

--クリビー
function c71036835.initial_effect(c)
	aux.AddCodeList(c,40640057)
	--to_hand
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(71036835,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_BATTLE_DESTROYED)
	e1:SetCountLimit(1,71036835)
	e1:SetTarget(c71036835.thtg)
	e1:SetOperation(c71036835.thop)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCondition(c71036835.thcon)
	c:RegisterEffect(e2)
	--negate attack
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(71036835,1))
	e3:SetType(EFFECT_TYPE_QUICK_O)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCode(EVENT_ATTACK_ANNOUNCE)
	e3:SetCountLimit(1)
	e3:SetCondition(c71036835.negcon)
	e3:SetOperation(c71036835.negop)
	c:RegisterEffect(e3)
end
function c71036835.thfilter(c)
	return aux.IsCodeListed(c,40640057) and c:IsAbleToHand() and c:IsType(TYPE_SPELL+TYPE_TRAP)
end
function c71036835.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c71036835.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c71036835.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c71036835.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
function c71036835.cfilter(c,tp)
	return c:IsControler(tp) and c:IsPreviousControler(tp) and c:IsPreviousSetCard(0xa4)
end
function c71036835.thcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c71036835.cfilter,1,nil,tp)
end
function c71036835.atfilter(c)
	return c:IsSetCard(0xa4) and c:IsFaceup() and c:IsAttackAbove(1)
end
function c71036835.negcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()~=tp and Duel.IsExistingMatchingCard(c71036835.atfilter,tp,LOCATION_MZONE,0,1,e:GetHandler())
end
function c71036835.negop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c71036835.atfilter,tp,LOCATION_MZONE,0,e:GetHandler())
	if #g==0 then return end
	for tc in aux.Next(g) do
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetValue(0)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
	end
	Duel.NegateAttack()
end
