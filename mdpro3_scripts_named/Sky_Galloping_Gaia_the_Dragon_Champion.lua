--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 天翔之龙骑士 盖亚  (ID: 2519690)
-- Type: Monster / Effect / Fusion
-- Attribute: WIND
-- Race: Dragon
-- Level 7
-- ATK 2600 | DEF 2100
--
-- Effect Text:
-- 「暗黑骑士 盖亚」怪兽＋龙族怪兽
-- ①：这张卡只要在怪兽区域存在，卡名当作「龙骑士 盖亚」使用。
-- ②：这张卡特殊召唤成功的场合才能发动。从自己的卡组·墓地选1张「螺旋枪杀」加入手卡。
-- ③：这张卡向对方怪兽攻击宣言时才能发动。那只对方怪兽的表示形式变更。
--[[ __CARD_HEADER_END__ ]]

--天翔の竜騎士ガイア
function c2519690.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcFun2(c,aux.FilterBoolFunction(Card.IsFusionSetCard,0xbd),aux.FilterBoolFunction(Card.IsRace,RACE_DRAGON),true)
	--change name
	aux.EnableChangeCode(c,66889139)
	--search
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(2519690,0))
	e2:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetTarget(c2519690.thtg)
	e2:SetOperation(c2519690.thop)
	c:RegisterEffect(e2)
	--position
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(2519690,1))
	e3:SetCategory(CATEGORY_POSITION)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_ATTACK_ANNOUNCE)
	e3:SetTarget(c2519690.postg)
	e3:SetOperation(c2519690.posop)
	c:RegisterEffect(e3)
end
function c2519690.thfilter(c)
	return c:IsCode(49328340) and c:IsAbleToHand()
end
function c2519690.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c2519690.thfilter,tp,LOCATION_GRAVE+LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_GRAVE+LOCATION_DECK)
end
function c2519690.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(c2519690.thfilter),tp,LOCATION_GRAVE+LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
function c2519690.postg(e,tp,eg,ep,ev,re,r,rp,chk)
	local d=Duel.GetAttackTarget()
	if chk==0 then return d and d:IsControler(1-tp) and d:IsCanChangePosition() end
	Duel.SetOperationInfo(0,CATEGORY_POSITION,d,1,0,0)
end
function c2519690.posop(e,tp,eg,ep,ev,re,r,rp)
	local d=Duel.GetAttackTarget()
	if d:IsRelateToBattle() then
		Duel.ChangePosition(d,POS_FACEUP_DEFENSE,POS_FACEDOWN_DEFENSE,POS_FACEUP_ATTACK,POS_FACEUP_ATTACK)
	end
end
