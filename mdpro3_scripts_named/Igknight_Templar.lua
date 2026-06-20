--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:37
-- Card: 点火骑士·德拉古诺夫  (ID: 97024987)
-- Type: Monster / Normal / Pendulum
-- Attribute: FIRE
-- Race: Warrior
-- Level 4
-- Pendulum Scales: L7 / R7
-- ATK 1700 | DEF 1300
-- Setcode: 200
--
-- Effect Text:
-- ←7 【灵摆】 7→
-- ①：另一边的自己的灵摆区域有「点火骑士」卡存在的场合才能发动。自己的灵摆区域的卡全部破坏，从自己的卡组·墓地选1只战士族·炎属性怪兽加入手卡。
-- 【怪兽描述】
-- 直性子讨厌歪门邪道的点火骑士老手战士。也许是那个性格的缘故，近来他好像对自己拿的武器抱有疑问。
--[[ __CARD_HEADER_END__ ]]

--イグナイト・ドラグノフ
function c97024987.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--tohand
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_DESTROY+CATEGORY_TOHAND+CATEGORY_SEARCH)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_PZONE)
	e2:SetCondition(c97024987.thcon)
	e2:SetTarget(c97024987.thtg)
	e2:SetOperation(c97024987.thop)
	c:RegisterEffect(e2)
end
function c97024987.thcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(Card.IsSetCard,tp,LOCATION_PZONE,0,1,e:GetHandler(),0xc8)
end
function c97024987.filter(c)
	return c:IsRace(RACE_WARRIOR) and c:IsAttribute(ATTRIBUTE_FIRE) and c:IsAbleToHand()
end
function c97024987.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c97024987.filter,tp,LOCATION_DECK+LOCATION_GRAVE,0,1,nil) end
	local g=Duel.GetFieldGroup(tp,LOCATION_PZONE,0)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,2,0,0)
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK+LOCATION_GRAVE)
end
function c97024987.thop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	local dg=Duel.GetFieldGroup(tp,LOCATION_PZONE,0)
	if dg:GetCount()<2 then return end
	if Duel.Destroy(dg,REASON_EFFECT)~=2 then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(c97024987.filter),tp,LOCATION_DECK+LOCATION_GRAVE,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
