--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 灵摆魔女  (ID: 43502497)
-- Type: Monster / Effect / Pendulum
-- Attribute: EARTH
-- Race: Spellcaster
-- Level 3
-- Pendulum Scales: L8 / R8
-- ATK 1500 | DEF 800
-- Setcode: 242
--
-- Effect Text:
-- ←8 【灵摆】 8→
-- 这个卡名的灵摆效果1回合只能使用1次。
-- ①：这张卡在灵摆区域存在的状态，自己场上的表侧表示的融合·同调·超量怪兽被战斗或者对方的效果破坏的场合才能发动。原本种族和那之内的1只相同的1只灵摆怪兽从卡组表侧加入额外卡组。
-- 【怪兽效果】
-- 这个卡名的①的怪兽效果1回合只能使用1次。
-- ①：这张卡召唤·灵摆召唤的场合，以自己的灵摆区域1张卡为对象才能发动。那张卡和这张卡破坏，从卡组把1只4星以下的灵摆怪兽加入手卡。
-- ②：怪兽区域的这张卡被破坏的场合才能发动。这张卡在自己的灵摆区域放置。
--[[ __CARD_HEADER_END__ ]]

--ペンデュラム・ウィッチ
local s,id,o=GetID()
function s.initial_effect(c)
	aux.EnablePendulumAttribute(c)
	--to extra
	local custom_code=aux.RegisterMergedDelayedEvent_ToSingleCard(c,id,EVENT_DESTROYED)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetCategory(CATEGORY_TOEXTRA)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(custom_code)
	e1:SetRange(LOCATION_PZONE)
	e1:SetCountLimit(1,id)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e1:SetCondition(s.txcon)
	e1:SetTarget(s.txtg)
	e1:SetOperation(s.txop)
	c:RegisterEffect(e1)
	--search
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(id,1))
	e2:SetCategory(CATEGORY_DESTROY+CATEGORY_SEARCH+CATEGORY_TOHAND)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_SUMMON_SUCCESS)
	e2:SetCountLimit(1,id+o)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DELAY)
	e2:SetTarget(s.thtg)
	e2:SetOperation(s.thop)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EVENT_SPSUMMON_SUCCESS)
	e3:SetCondition(s.thcon)
	c:RegisterEffect(e3)
	--to scale
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(id,2))
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e4:SetCode(EVENT_DESTROYED)
	e4:SetProperty(EFFECT_FLAG_DELAY)
	e4:SetCondition(s.pzcon)
	e4:SetTarget(s.pztg)
	e4:SetOperation(s.pzop)
	c:RegisterEffect(e4)
end
function s.cfilter(c,tp,tgchk)
	return c:IsPreviousPosition(POS_FACEUP) and c:GetPreviousTypeOnField()&(TYPE_FUSION+TYPE_SYNCHRO+TYPE_XYZ)>0
		and c:IsPreviousLocation(LOCATION_MZONE) and c:IsPreviousControler(tp)
		and (c:IsReason(REASON_BATTLE) or c:IsReason(REASON_EFFECT) and c:GetReasonPlayer()==1-tp)
		and (tgchk or Duel.IsExistingMatchingCard(s.filter,tp,LOCATION_DECK,0,1,nil,c:GetOriginalRace()))
end
function s.filter(c,race)
	return c:IsType(TYPE_PENDULUM) and (c:GetOriginalRace()&race)>0
end
function s.txcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(s.cfilter,1,nil,tp,false)
end
function s.txtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local g=eg:Filter(s.cfilter,nil,tp,true)
	local race=0
	for tc in aux.Next(g) do
		race=race|tc:GetOriginalRace()
	end
	e:SetLabel(race)
	Duel.SetOperationInfo(0,CATEGORY_TOEXTRA,nil,1,tp,LOCATION_DECK)
end
function s.txop(e,tp,eg,ep,ev,re,r,rp)
	local race=e:GetLabel()
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(id,3))
	local tg=Duel.SelectMatchingCard(tp,s.filter,tp,LOCATION_DECK,0,1,1,nil,race)
	if #tg>0 then
		Duel.SendtoExtraP(tg,nil,REASON_EFFECT)
	end
end
function s.sfilter(c)
	return c:IsLevelBelow(4) and c:IsType(TYPE_PENDULUM) and c:IsAbleToHand()
end
function s.thtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_PZONE) and chkc:IsControler(tp) end
	if chk==0 then return Duel.IsExistingTarget(nil,tp,LOCATION_PZONE,0,1,nil)
		and Duel.IsExistingMatchingCard(s.sfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,nil,tp,LOCATION_PZONE,0,1,1,nil)+e:GetHandler()
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,2,0,0)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function s.thop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	local g=Group.FromCards(c,tc):Filter(Card.IsRelateToChain,nil)
	if #g<2 or Duel.Destroy(g,REASON_EFFECT)<2 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local sg=Duel.SelectMatchingCard(tp,s.sfilter,tp,LOCATION_DECK,0,1,1,nil)
	if #sg==0 then return end
	Duel.SendtoHand(sg,nil,REASON_EFFECT)
	Duel.ConfirmCards(1-tp,sg)
end
function s.thcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_PENDULUM)
end
function s.pzcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsPreviousLocation(LOCATION_MZONE) and c:IsFaceupEx()
end
function s.pztg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLocation(tp,LOCATION_PZONE,0) or Duel.CheckLocation(tp,LOCATION_PZONE,1) end
end
function s.pzop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsRelateToChain() then Duel.MoveToField(c,tp,tp,LOCATION_PZONE,POS_FACEUP,true) end
end
