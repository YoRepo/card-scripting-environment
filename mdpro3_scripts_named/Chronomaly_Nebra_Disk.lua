--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 先史遗产 内布拉星象盘  (ID: 24861088)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Machine
-- Level 4
-- ATK 1800 | DEF 1500
-- Setcode: 112
--
-- Effect Text:
-- 这个卡名的①②的效果1回合只能有1次使用其中任意1个。
-- ①：这张卡召唤成功时才能发动。从卡组把「先史遗产 内布拉星象盘」以外的1张「先史遗产」卡加入手卡。
-- ②：这张卡在墓地存在，自己场上的怪兽只有「先史遗产」怪兽的场合才能发动。这张卡守备表示特殊召唤。这个效果发动的回合，自己不能把「先史遗产」卡以外的卡的效果发动。
--[[ __CARD_HEADER_END__ ]]

--先史遺産ネブラ・ディスク
function c24861088.initial_effect(c)
	--search
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(24861088,0))
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetCountLimit(1,24861088)
	e1:SetTarget(c24861088.target)
	e1:SetOperation(c24861088.operation)
	c:RegisterEffect(e1)
	--special summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(24861088,1))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_GRAVE)
	e2:SetCountLimit(1,24861088)
	e2:SetCondition(c24861088.spcon)
	e2:SetCost(c24861088.spcost)
	e2:SetTarget(c24861088.sptg)
	e2:SetOperation(c24861088.spop)
	c:RegisterEffect(e2)
	Duel.AddCustomActivityCounter(24861088,ACTIVITY_CHAIN,c24861088.chainfilter)
end
function c24861088.chainfilter(re,tp,cid)
	return re:GetHandler():IsSetCard(0x70)
end
function c24861088.filter(c)
	return c:IsSetCard(0x70) and not c:IsCode(24861088) and c:IsAbleToHand()
end
function c24861088.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c24861088.filter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c24861088.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c24861088.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
function c24861088.cfilter(c)
	return c:IsFacedown() or not c:IsSetCard(0x70)
end
function c24861088.spcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)>0
		and not Duel.IsExistingMatchingCard(c24861088.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c24861088.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetCustomActivityCount(24861088,tp,ACTIVITY_CHAIN)==0 end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EFFECT_CANNOT_ACTIVATE)
	e1:SetTargetRange(1,0)
	e1:SetValue(c24861088.aclimit)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c24861088.aclimit(e,re,tp)
	return not re:GetHandler():IsSetCard(0x70)
end
function c24861088.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false,POS_FACEUP_DEFENSE) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c24861088.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToEffect(e) then
		Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP_DEFENSE)
	end
end
