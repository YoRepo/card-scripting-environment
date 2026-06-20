--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:28
-- Card: 海洋怪鱼卫士  (ID: 45045866)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Fish
-- Level 3
-- ATK 1500 | DEF 1200
--
-- Effect Text:
-- 这张卡攻击守备表示怪兽时，若攻击力超过那个守备力，给与对方基本分那个数值的战斗伤害。这张卡被战斗破坏的场合，从自己卡组把1只「千眼卵鱼」或「母脑鱼」加入手卡。
--[[ __CARD_HEADER_END__ ]]

--オーシャンズ・オーパー
function c45045866.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_PIERCE)
	c:RegisterEffect(e1)
	--special summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(45045866,0))
	e2:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_BATTLE_DESTROYED)
	e2:SetTarget(c45045866.target)
	e2:SetOperation(c45045866.operation)
	c:RegisterEffect(e2)
end
function c45045866.filter(c)
	return c:IsCode(81434470,18828179) and c:IsAbleToHand()
end
function c45045866.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c45045866.operation(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c45045866.filter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end
