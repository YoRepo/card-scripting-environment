--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 救援机人  (ID: 24311595)
-- Type: Monster / Effect
-- Attribute: FIRE
-- Race: Machine
-- Level 6
-- ATK 1600 | DEF 1800
-- Setcode: 22
--
-- Effect Text:
-- 只要这张卡在自己场上表侧表示存在，自己场上存在的名字带有「机人」的怪兽被战斗破坏送去墓地时，可以使那只怪兽回到手卡。
--[[ __CARD_HEADER_END__ ]]

--レスキューロイド
function c24311595.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(24311595,0))
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetCode(EVENT_BATTLE_DESTROYED)
	e1:SetTarget(c24311595.target)
	e1:SetOperation(c24311595.activate)
	c:RegisterEffect(e1)
end
function c24311595.filter(c,tp)
	return c:IsLocation(LOCATION_GRAVE) and c:IsReason(REASON_BATTLE) and c:IsPreviousControler(tp)
		and c:IsSetCard(0x16) and c:IsAbleToHand()
end
function c24311595.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		local g=eg:Filter(c24311595.filter,nil,tp)
		e:SetLabelObject(g:GetFirst())
		return g:GetCount()~=0
	end
	Duel.SetTargetCard(e:GetLabelObject())
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,e:GetLabelObject(),1,0,0)
end
function c24311595.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if e:GetHandler():IsRelateToEffect(e) and tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
	end
end
