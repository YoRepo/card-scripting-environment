--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: No.1 感染蝇王 巴力·西卜  (ID: 10666000)
-- Type: Monster / Effect / Xyz
-- Attribute: DARK
-- Race: Fiend
-- Rank 8
-- ATK 3000 | DEF 2500
-- Setcode: 72
--
-- Effect Text:
-- 8星怪兽×2只以上
-- 这个卡名的①②的效果1回合各能使用1次。
-- ①：这张卡超量召唤的场合才能发动。把对方的额外卡组确认，那之内的1张送去墓地。
-- ②：把这张卡1个超量素材取除，以对方场上1张卡为对象才能发动。那张卡破坏。这个效果把表侧表示怪兽破坏的场合，再给与对方那个攻击力一半数值的伤害。
-- ③：自己准备阶段才能发动。把对方墓地1张卡作为这张卡的超量素材。
--[[ __CARD_HEADER_END__ ]]

--No.1 インフェクション・バアル・ゼブル
local s,id,o=GetID()
function s.initial_effect(c)
	c:EnableReviveLimit()
	--material
	aux.AddXyzProcedure(c,nil,8,2,nil,nil,99)
	--attach
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCondition(s.atcon)
	e1:SetTarget(s.attg)
	e1:SetOperation(s.atop)
	c:RegisterEffect(e1)
	--to grave
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(id,1))
	e2:SetCategory(CATEGORY_TOGRAVE)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetCountLimit(1,id)
	e2:SetProperty(EFFECT_FLAG_DELAY)
	e2:SetCondition(s.tgcon)
	e2:SetTarget(s.tgtg)
	e2:SetOperation(s.tgop)
	c:RegisterEffect(e2)
	--destroy
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(id,2))
	e3:SetCategory(CATEGORY_DESTROY+CATEGORY_DAMAGE)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1,id+o)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetCost(s.descost)
	e3:SetTarget(s.destg)
	e3:SetOperation(s.desop)
	c:RegisterEffect(e3)
end
aux.xyz_number[id]=1
function s.atcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==tp
end
function s.attg(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=Duel.GetFieldGroup(tp,0,LOCATION_GRAVE)
	if chk==0 then return #g>0 end
	Duel.SetOperationInfo(0,CATEGORY_LEAVE_GRAVE,g,1,0,0)
end
function s.atop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_XMATERIAL)
	local g=Duel.GetFieldGroup(tp,0,LOCATION_GRAVE)
	if aux.NecroValleyNegateCheck(g) then return end
	local tg=g:Select(tp,1,1,nil)
	if #tg>0 then
		Duel.Overlay(c,tg)
	end
end
function s.tgcon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():IsSummonType(SUMMON_TYPE_XYZ)
end
function s.tgtg(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=Duel.GetMatchingGroup(Card.IsAbleToGrave,tp,0,LOCATION_EXTRA,nil)
	if chk==0 then return #g>0 end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,g,1,0,0)
end
function s.tgop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetFieldGroup(tp,0,LOCATION_EXTRA)
	if #g==0 then return end
	Duel.ConfirmCards(tp,g,true)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local sg=g:FilterSelect(tp,Card.IsAbleToGrave,1,1,nil)
	Duel.SendtoGrave(sg,REASON_EFFECT)
	Duel.ShuffleExtra(1-tp)
end
function s.descost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:CheckRemoveOverlayCard(tp,1,REASON_COST) end
	c:RemoveOverlayCard(tp,1,1,REASON_COST)
end
function s.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and chkc:IsControler(1-tp) end
	if chk==0 then return Duel.IsExistingTarget(nil,tp,0,LOCATION_ONFIELD,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local tc=Duel.SelectTarget(tp,nil,tp,0,LOCATION_ONFIELD,1,1,nil):GetFirst()
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,tc,1,0,0)
	if tc:IsLocation(LOCATION_MZONE) then
		local atk=0
		if tc:IsFaceup() then tc:GetAttack() end
		Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,atk//2)
	end
end
function s.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if not tc:IsRelateToEffect(e) then return end
	local atk=0
	if tc:IsFaceup() then atk=tc:GetAttack() end
	if Duel.Destroy(tc,REASON_EFFECT)>0 and tc:IsPreviousLocation(LOCATION_MZONE) and atk>0 then
		Duel.BreakEffect()
		Duel.Damage(1-tp,atk//2,REASON_EFFECT)
	end
end
