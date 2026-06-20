--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:31
-- Card: 电子光虫-核心菜粉蝶  (ID: 58600555)
-- Type: Monster / Effect / Xyz
-- Attribute: LIGHT
-- Race: Insect
-- Rank 5
-- ATK 2200 | DEF 1800
--
-- Effect Text:
-- 昆虫族·光属性5星怪兽×2只以上
-- 这张卡也能从自己场上的3·4阶的昆虫族超量怪兽把2个超量素材取除，在那只超量怪兽上面重叠来超量召唤。
-- ①：1回合1次，把这张卡1个超量素材取除，以对方场上1只守备表示怪兽为对象才能发动。那只怪兽回到持有者卡组。
-- ②：1回合1次，场上的怪兽的表示形式变更的场合才能发动。选自己墓地1只昆虫族怪兽在这张卡下面重叠作为超量素材。
--[[ __CARD_HEADER_END__ ]]

--電子光虫－コアベージ
function c58600555.initial_effect(c)
	c:EnableReviveLimit()
	--xyz summon
	aux.AddXyzProcedure(c,c58600555.mfilter,5,2,c58600555.ovfilter,aux.Stringid(58600555,2),99,c58600555.xyzop)
	--Back to Deck
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(58600555,0))
	e2:SetCategory(CATEGORY_TODECK)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCost(c58600555.tdcost)
	e2:SetTarget(c58600555.tdtg)
	e2:SetOperation(c58600555.tdop)
	c:RegisterEffect(e2)
	--Change position
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(58600555,1))
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1)
	e3:SetCode(EVENT_CHANGE_POS)
	e3:SetProperty(EFFECT_FLAG_DELAY)
	e3:SetCondition(c58600555.condition)
	e3:SetTarget(c58600555.target)
	e3:SetOperation(c58600555.operation)
	c:RegisterEffect(e3)
end
function c58600555.ovfilter(c)
	return c:IsFaceup() and c:IsXyzType(TYPE_XYZ) and c:IsRank(3,4) and c:IsRace(RACE_INSECT)
end
function c58600555.mfilter(c)
	return c:IsRace(RACE_INSECT) and c:IsAttribute(ATTRIBUTE_LIGHT)
end
function c58600555.xyzop(e,tp,chk,mc)
	if chk==0 then return mc:CheckRemoveOverlayCard(tp,2,REASON_COST) end
	mc:RemoveOverlayCard(tp,2,2,REASON_COST)
end
function c58600555.tdcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c58600555.tdfilter(c)
	return c:IsPosition(POS_DEFENSE) and c:IsAbleToDeck()
end
function c58600555.tdtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and c58600555.tdfilter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c58600555.tdfilter,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectTarget(tp,c58600555.tdfilter,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,g,1,0,0)
end
function c58600555.tdop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		Duel.SendtoDeck(tc,nil,SEQ_DECKSHUFFLE,REASON_EFFECT)
	end
end
function c58600555.cfilter(c)
	local np=c:GetPosition()
	local pp=c:GetPreviousPosition()
	return ((np<3 and pp>3) or (pp<3 and np>3))
end
function c58600555.condition(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c58600555.cfilter,1,nil)
end
function c58600555.matfilter(c)
	return c:IsRace(RACE_INSECT) and c:IsCanOverlay()
end
function c58600555.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsType(TYPE_XYZ)
		and Duel.IsExistingMatchingCard(c58600555.matfilter,tp,LOCATION_GRAVE,0,1,nil) end
end
function c58600555.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_XMATERIAL)
	local g=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(c58600555.matfilter),tp,LOCATION_GRAVE,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.Overlay(c,g)
	end
end
