--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:37
-- Card: 冥界骑士 崔斯坦  (ID: 96163807)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Zombie
-- Level 4
-- ATK 1800 | DEF 0
--
-- Effect Text:
-- ①：这张卡召唤成功时，以自己墓地1只守备力0的不死族怪兽为对象才能发动。那张卡加入手卡。
-- ②：自己场上有这张卡以外的不死族怪兽存在的场合，这张卡的攻击力上升300。
--[[ __CARD_HEADER_END__ ]]

--冥界騎士トリスタン
function c96163807.initial_effect(c)
	--tohand
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetTarget(c96163807.thtg)
	e1:SetOperation(c96163807.thop)
	c:RegisterEffect(e1)
	--atk
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetCondition(c96163807.atkcon)
	e2:SetValue(300)
	c:RegisterEffect(e2)
end
function c96163807.thfilter(c)
	return c:IsDefense(0) and c:IsRace(RACE_ZOMBIE) and c:IsAbleToHand()
end
function c96163807.thtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c96163807.thfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c96163807.thfilter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectTarget(tp,c96163807.thfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,1,0,0)
end
function c96163807.thop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
	end
end
function c96163807.atkfilter(c)
	return c:IsFaceup() and c:IsRace(RACE_ZOMBIE)
end
function c96163807.atkcon(e)
	return Duel.IsExistingMatchingCard(c96163807.atkfilter,e:GetHandlerPlayer(),LOCATION_MZONE,0,1,e:GetHandler())
end
