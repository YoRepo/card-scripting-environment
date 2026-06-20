--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 彼岸的恶鬼 斯卡尔米利奥内  (ID: 84764038)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Fiend
-- Level 3
-- ATK 800 | DEF 2000
-- Setcode: 177
--
-- Effect Text:
-- 这个卡名的①③的效果1回合只能有1次使用其中任意1个。
-- ①：自己场上没有魔法·陷阱卡存在的场合才能发动。这张卡从手卡特殊召唤。
-- ②：自己场上有「彼岸」怪兽以外的怪兽存在的场合这张卡破坏。
-- ③：这张卡被送去墓地的回合的结束阶段才能发动。从卡组把「彼岸的恶鬼 斯卡尔米利奥内」以外的1只恶魔族·暗属性·3星怪兽加入手卡。
--[[ __CARD_HEADER_END__ ]]

--彼岸の悪鬼 スカラマリオン
function c84764038.initial_effect(c)
	--self destroy
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_SELF_DESTROY)
	e1:SetCondition(c84764038.sdcon)
	c:RegisterEffect(e1)
	--Special Summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(84764038,0))
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetRange(LOCATION_HAND)
	e2:SetCountLimit(1,84764038)
	e2:SetCondition(c84764038.sscon)
	e2:SetTarget(c84764038.sstg)
	e2:SetOperation(c84764038.ssop)
	c:RegisterEffect(e2)
	--to grave
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e3:SetCode(EVENT_TO_GRAVE)
	e3:SetOperation(c84764038.regop)
	c:RegisterEffect(e3)
	--search
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(84764038,1))
	e4:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e4:SetCode(EVENT_PHASE+PHASE_END)
	e4:SetCountLimit(1,84764038)
	e4:SetRange(LOCATION_GRAVE)
	e4:SetCondition(c84764038.thcon)
	e4:SetTarget(c84764038.thtg)
	e4:SetOperation(c84764038.thop)
	c:RegisterEffect(e4)
end
function c84764038.sdfilter(c)
	return c:IsFacedown() or not c:IsSetCard(0xb1)
end
function c84764038.sdcon(e)
	return Duel.IsExistingMatchingCard(c84764038.sdfilter,e:GetHandlerPlayer(),LOCATION_MZONE,0,1,nil)
end
function c84764038.filter(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP)
end
function c84764038.sscon(e,tp,eg,ep,ev,re,r,rp)
	return not Duel.IsExistingMatchingCard(c84764038.filter,tp,LOCATION_ONFIELD,0,1,nil)
end
function c84764038.sstg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c84764038.ssop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)
end
function c84764038.regop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	c:RegisterFlagEffect(84764038,RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END,0,1)
end
function c84764038.thfilter(c)
	return c:IsLevel(3) and c:IsAttribute(ATTRIBUTE_DARK) and c:IsRace(RACE_FIEND)
		and not c:IsCode(84764038) and c:IsAbleToHand()
end
function c84764038.thcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetFlagEffect(84764038)>0
end
function c84764038.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c84764038.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c84764038.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c84764038.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
