--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:35
-- Card: 鹰身女妖的羽毛吹雪  (ID: 87639778)
-- Type: Trap
-- ATK 0 | DEF 0
-- Setcode: 100
--
-- Effect Text:
-- 自己场上有「鹰身」怪兽存在的场合，这张卡的发动从手卡也能用。
-- ①：自己场上有鸟兽族·风属性怪兽存在的场合才能发动。直到回合结束时，对方发动的怪兽的效果无效化。
-- ②：魔法与陷阱区域的这张卡被对方的效果破坏的场合才能发动。从自己的卡组·墓地选1张「鹰身女妖的羽毛扫」加入手卡。
--[[ __CARD_HEADER_END__ ]]

--ハーピィの羽根吹雪
function c87639778.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCondition(c87639778.condition)
	e1:SetTarget(c87639778.target)
	e1:SetOperation(c87639778.activate)
	c:RegisterEffect(e1)
	--act in hand
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(87639778,1))
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_TRAP_ACT_IN_HAND)
	e2:SetCondition(c87639778.handcon)
	c:RegisterEffect(e2)
	--search
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(87639778,0))
	e3:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e3:SetCode(EVENT_DESTROYED)
	e3:SetProperty(EFFECT_FLAG_DELAY)
	e3:SetCondition(c87639778.thcon)
	e3:SetTarget(c87639778.thtg)
	e3:SetOperation(c87639778.thop)
	c:RegisterEffect(e3)
end
function c87639778.disfilter(c)
	return c:IsFaceup() and c:IsRace(RACE_WINDBEAST) and c:IsAttribute(ATTRIBUTE_WIND)
end
function c87639778.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(c87639778.disfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c87639778.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFlagEffect(tp,87639778)==0 end
end
function c87639778.activate(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_CHAIN_SOLVING)
	e1:SetCondition(c87639778.discon)
	e1:SetOperation(c87639778.disop)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
	Duel.RegisterFlagEffect(tp,87639778,RESET_PHASE+PHASE_END,0,1)
end
function c87639778.discon(e,tp,eg,ep,ev,re,r,rp)
	return re:IsActiveType(TYPE_MONSTER) and rp==1-tp
end
function c87639778.disop(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateEffect(ev)
end
function c87639778.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x64)
end
function c87639778.handcon(e)
	return Duel.IsExistingMatchingCard(c87639778.filter,e:GetHandlerPlayer(),LOCATION_MZONE,0,1,nil)
end
function c87639778.thcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return rp==1-tp and c:IsReason(REASON_EFFECT)
		and c:IsPreviousControler(tp) and c:IsPreviousLocation(LOCATION_SZONE)
end
function c87639778.thfilter(c)
	return c:IsCode(18144506) and c:IsAbleToHand()
end
function c87639778.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c87639778.thfilter,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK+LOCATION_GRAVE)
end
function c87639778.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(c87639778.thfilter),tp,LOCATION_DECK+LOCATION_GRAVE,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
