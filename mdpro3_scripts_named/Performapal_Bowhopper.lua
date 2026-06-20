--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:27
-- Card: 娱乐伙伴 弩弓蝗虫  (ID: 37745740)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Insect
-- Level 4
-- ATK 1500 | DEF 1000
-- Setcode: 159
--
-- Effect Text:
-- 「娱乐伙伴 弩弓蝗虫」的①②的效果1回合各能使用1次。
-- ①：把自己场上1只「娱乐伙伴」怪兽解放才能发动。给与对方解放的怪兽的等级×100伤害。
-- ②：把自己场上1只「娱乐伙伴」怪兽解放，以解放的怪兽以外的自己墓地1只「娱乐伙伴」怪兽为对象才能发动。那只怪兽加入手卡。
--[[ __CARD_HEADER_END__ ]]

--EMガンバッター
function c37745740.initial_effect(c)
	--damage
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(37745740,0))
	e1:SetCategory(CATEGORY_DAMAGE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1,37745740)
	e1:SetCost(c37745740.cost)
	e1:SetTarget(c37745740.target)
	e1:SetOperation(c37745740.operation)
	c:RegisterEffect(e1)
	--tohand
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(37745740,1))
	e2:SetCategory(CATEGORY_TOHAND)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1,37745741)
	e2:SetCost(c37745740.thcost)
	e2:SetTarget(c37745740.thtg)
	e2:SetOperation(c37745740.thop)
	c:RegisterEffect(e2)
end
function c37745740.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,Card.IsSetCard,1,nil,0x9f) end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	local g=Duel.SelectReleaseGroup(tp,Card.IsSetCard,1,1,nil,0x9f)
	e:SetLabel(g:GetFirst():GetLevel()*100)
	Duel.Release(g,REASON_COST)
end
function c37745740.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(e:GetLabel())
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,e:GetLabel())
end
function c37745740.operation(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end
function c37745740.thcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckReleaseGroup(tp,Card.IsSetCard,1,nil,0x9f) end
	Duel.Hint(HINT_OPSELECTED,1-tp,e:GetDescription())
	local g=Duel.SelectReleaseGroup(tp,Card.IsSetCard,1,1,nil,0x9f)
	e:SetLabelObject(g:GetFirst())
	Duel.Release(g,REASON_COST)
end
function c37745740.thfilter(c)
	return c:IsSetCard(0x9f) and c:IsType(TYPE_MONSTER) and c:IsAbleToHand()
end
function c37745740.thtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c37745740.thfilter(chkc) and chkc~=e:GetLabelObject() end
	if chk==0 then return Duel.IsExistingTarget(c37745740.thfilter,tp,LOCATION_GRAVE,0,1,e:GetLabelObject()) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectTarget(tp,c37745740.thfilter,tp,LOCATION_GRAVE,0,1,1,e:GetLabelObject())
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,g,g:GetCount(),0,0)
end
function c37745740.thop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SendtoHand(tc,nil,REASON_EFFECT)
	end
end
