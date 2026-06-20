--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:34
-- Card: 鬼计僵尸  (ID: 80885284)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Zombie
-- Level 3
-- ATK 400 | DEF 1800
-- Setcode: 141
--
-- Effect Text:
-- 自己场上有名字带有「鬼计」的怪兽存在的场合才能让这张卡表侧表示召唤。这张卡1回合只有1次可以变成里侧守备表示。此外，这张卡反转时，可以把持有自己场上的名字带有「鬼计」的怪兽数量以下的等级的1只名字带有
-- 「鬼计」的怪兽从卡组加入手卡。「鬼计僵尸」的这个效果1回合只能使用1次。
--[[ __CARD_HEADER_END__ ]]

--ゴーストリック・キョンシー
function c80885284.initial_effect(c)
	--summon limit
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CANNOT_SUMMON)
	e1:SetCondition(c80885284.sumcon)
	c:RegisterEffect(e1)
	--turn set
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(80885284,0))
	e2:SetCategory(CATEGORY_POSITION+CATEGORY_MSET)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTarget(c80885284.postg)
	e2:SetOperation(c80885284.posop)
	c:RegisterEffect(e2)
	--search
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(80885284,1))
	e3:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_FLIP)
	e3:SetCountLimit(1,80885284)
	e3:SetTarget(c80885284.thtg)
	e3:SetOperation(c80885284.thop)
	c:RegisterEffect(e3)
end
function c80885284.sfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x8d)
end
function c80885284.sumcon(e)
	return not Duel.IsExistingMatchingCard(c80885284.sfilter,e:GetHandlerPlayer(),LOCATION_MZONE,0,1,nil)
end
function c80885284.postg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsCanTurnSet() and c:GetFlagEffect(80885284)==0 end
	c:RegisterFlagEffect(80885284,RESET_EVENT+RESETS_STANDARD-RESET_TURN_SET+RESET_PHASE+PHASE_END,0,1)
	Duel.SetOperationInfo(0,CATEGORY_POSITION,c,1,0,0)
end
function c80885284.posop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) and c:IsFaceup() then
		Duel.ChangePosition(c,POS_FACEDOWN_DEFENSE)
	end
end
function c80885284.thfilter(c,lv)
	return c:IsLevelBelow(lv) and c:IsSetCard(0x8d) and c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
end
function c80885284.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		local count=Duel.GetMatchingGroupCount(c80885284.sfilter,tp,LOCATION_MZONE,0,nil)
		return Duel.IsExistingMatchingCard(c80885284.thfilter,tp,LOCATION_DECK,0,1,nil,count)
	end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c80885284.thop(e,tp,eg,ep,ev,re,r,rp)
	local count=Duel.GetMatchingGroupCount(c80885284.sfilter,tp,LOCATION_MZONE,0,nil)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c80885284.thfilter,tp,LOCATION_DECK,0,1,1,nil,count)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
