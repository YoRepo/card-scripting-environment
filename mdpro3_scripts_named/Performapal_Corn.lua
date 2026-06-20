--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:26
-- Card: 娱乐伙伴 小角  (ID: 33103459)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Beast-Warrior
-- Level 3
-- ATK 600 | DEF 1000
-- Setcode: 159
--
-- Effect Text:
-- ①：这张卡召唤·特殊召唤成功的回合的自己主要阶段只有1次，以这张卡以外的自己场上1只攻击力1000以下的「娱乐伙伴」怪兽为对象才能发动。自己场上的同是表侧攻击表示的那只怪兽和这张卡变成守备表示，从卡组
-- 把1只「异色眼」怪兽加入手卡。
-- ②：对方回合，从自己墓地把这张卡和1只「娱乐伙伴 小角」以外的「娱乐伙伴」怪兽除外才能发动。自己回复500基本分。
--[[ __CARD_HEADER_END__ ]]

--EMコン
function c33103459.initial_effect(c)
	--to hand
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(33103459,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCondition(c33103459.thcon)
	e1:SetTarget(c33103459.thtg)
	e1:SetOperation(c33103459.thop)
	c:RegisterEffect(e1)
	--lp recover
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(33103459,1))
	e2:SetCategory(CATEGORY_RECOVER)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetCode(EVENT_FREE_CHAIN)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCondition(c33103459.lpcon)
	e2:SetCost(c33103459.lpcost)
	e2:SetTarget(c33103459.lptg)
	e2:SetOperation(c33103459.lpop)
	c:RegisterEffect(e2)
	if not c33103459.global_check then
		c33103459.global_check=true
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_SUMMON_SUCCESS)
		ge1:SetLabel(33103459)
		ge1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		ge1:SetOperation(aux.sumreg)
		Duel.RegisterEffect(ge1,0)
		local ge2=ge1:Clone()
		ge2:SetCode(EVENT_SPSUMMON_SUCCESS)
		ge2:SetLabel(33103459)
		Duel.RegisterEffect(ge2,0)
	end
end
function c33103459.thcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetFlagEffect(33103459)~=0
end
function c33103459.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x9f) and c:IsAttackBelow(1000)
		and c:IsPosition(POS_FACEUP_ATTACK) and c:IsCanChangePosition()
end
function c33103459.thfilter(c)
	return c:IsSetCard(0x99) and c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
end
function c33103459.thtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c33103459.filter(chkc) and chkc~=e:GetHandler() end
	if chk==0 then return Duel.IsExistingMatchingCard(c33103459.thfilter,tp,LOCATION_DECK,0,1,nil)
		and e:GetHandler():IsPosition(POS_FACEUP_ATTACK)
		and Duel.IsExistingTarget(c33103459.filter,tp,LOCATION_MZONE,0,1,e:GetHandler()) end
	local g=Duel.SelectTarget(tp,c33103459.filter,tp,LOCATION_MZONE,0,1,1,e:GetHandler())
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c33103459.thop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and c:IsPosition(POS_FACEUP_ATTACK) and c:IsControler(tp)
		and tc:IsRelateToEffect(e) and tc:IsPosition(POS_FACEUP_ATTACK) and tc:IsControler(tp)
		and Duel.ChangePosition(Group.FromCards(c,tc),POS_FACEUP_DEFENSE)==2 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
		local g=Duel.SelectMatchingCard(tp,c33103459.thfilter,tp,LOCATION_DECK,0,1,1,nil)
		if g:GetCount()>0 then
			Duel.SendtoHand(g,nil,REASON_EFFECT)
			Duel.ConfirmCards(1-tp,g)
		end
	end
end
function c33103459.cfilter(c)
	return c:IsSetCard(0x9f) and c:IsType(TYPE_MONSTER) and c:IsAbleToRemoveAsCost() and not c:IsCode(33103459)
end
function c33103459.lpcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()~=tp
end
function c33103459.lpcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemoveAsCost()
		and Duel.IsExistingMatchingCard(c33103459.cfilter,tp,LOCATION_GRAVE,0,1,e:GetHandler()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c33103459.cfilter,tp,LOCATION_GRAVE,0,1,1,e:GetHandler())
	g:AddCard(e:GetHandler())
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c33103459.lptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(500)
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,500)
end
function c33103459.lpop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Recover(p,d,REASON_EFFECT)
end
