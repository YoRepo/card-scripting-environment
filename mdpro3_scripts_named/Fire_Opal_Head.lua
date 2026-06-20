--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:25
-- Card: 火蛋白石头龙头领  (ID: 28363749)
-- Type: Monster / Normal / Pendulum
-- Attribute: FIRE
-- Race: Dinosaur
-- Level 6
-- ATK 2500 | DEF 1000
--
-- Effect Text:
-- ←0 【灵摆】 0→
-- 【怪兽描述】
-- 正在熊熊燃烧的石脑袋恐龙番长。以其生龙活虎般的动作及火焰来作弄敌人，再用必杀的火蛋白石头龙头锤狠狠招呼对方。
--[[ __CARD_HEADER_END__ ]]

--ファイヤーオパールヘッド
function c28363749.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
end
