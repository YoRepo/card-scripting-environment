--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:23
-- Card: 进化龙·梁龙  (ID: 17045014)
-- Type: Monster / Effect
-- Attribute: FIRE
-- Race: Dinosaur
-- Level 4
-- ATK 1600 | DEF 800
-- Setcode: 24654
--
-- Effect Text:
-- 这张卡用名字带有「进化虫」的怪兽的效果特殊召唤成功时，选择对方场上存在的1张魔法·陷阱卡破坏。
--[[ __CARD_HEADER_END__ ]]

--エヴォルダー・ディプロドクス
function c17045014.initial_effect(c)
	--destroy
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(17045014,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(aux.evospcon)
	e1:SetTarget(c17045014.destg)
	e1:SetOperation(c17045014.desop)
	c:RegisterEffect(e1)
end
function c17045014.desfilter(c)
	return c:IsType(TYPE_SPELL+TYPE_TRAP)
end
function c17045014.destg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsOnField() and chkc:IsControler(1-tp) and c17045014.desfilter(chkc) end
	if chk==0 then return true end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESTROY)
	local g=Duel.SelectTarget(tp,c17045014.desfilter,tp,0,LOCATION_ONFIELD,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c17045014.desop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
