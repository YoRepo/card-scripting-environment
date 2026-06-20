--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 黄昏之忍者-新月  (ID: 14541657)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Warrior
-- Level 4
-- ATK 1500 | DEF 100
-- Setcode: 43
--
-- Effect Text:
-- 「黄昏之忍者-新月」的②的效果1回合只能使用1次。
-- ①：只要这张卡在怪兽区域存在，对方不能把其他的「忍者」怪兽作为攻击对象，也不能作为效果的对象。
-- ②：这张卡被战斗或者对方的效果破坏送去墓地的场合才能发动。从卡组把「黄昏之忍者-新月」以外的1只「忍者」怪兽加入手卡。
--[[ __CARD_HEADER_END__ ]]

--黄昏の忍者－シンゲツ
function c14541657.initial_effect(c)
	--untargetable
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_SELECT_BATTLE_TARGET)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(0,LOCATION_MZONE)
	e1:SetValue(c14541657.atlimit)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e2:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e2:SetTarget(c14541657.tglimit)
	e2:SetValue(aux.tgoval)
	c:RegisterEffect(e2)
	--tohand
	local e3=Effect.CreateEffect(c)
	e3:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_TO_GRAVE)
	e3:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e3:SetCountLimit(1,14541657)
	e3:SetCondition(c14541657.thcon)
	e3:SetTarget(c14541657.thtg)
	e3:SetOperation(c14541657.thop)
	c:RegisterEffect(e3)
end
function c14541657.atlimit(e,c)
	return c:IsFaceup() and c:IsSetCard(0x2b) and c~=e:GetHandler()
end
function c14541657.tglimit(e,c)
	return c:IsSetCard(0x2b) and c~=e:GetHandler()
end
function c14541657.thcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsReason(REASON_BATTLE)
		or (rp==1-tp and c:IsReason(REASON_DESTROY) and c:IsPreviousControler(tp))
end
function c14541657.thfilter(c)
	return c:IsSetCard(0x2b) and c:IsType(TYPE_MONSTER) and not c:IsCode(14541657) and c:IsAbleToHand()
end
function c14541657.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c14541657.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c14541657.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c14541657.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
